import logging
import pathlib
import select
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor

import grpc

import util
from protos import gchat_pb2, gchat_pb2_grpc


INPUT_FROM_TERMINAL = util.input_is_from_terminal()
logging.basicConfig(level=logging.DEBUG)
_LOGGER = logging.getLogger(__name__)


class ChatUser:
    def __init__(
        self,
        executor: ThreadPoolExecutor,
        channel: grpc.Channel,
        name: str,
        emit_message: bool = True,
        emit_stat: bool = False,
    ) -> None:
        self._executor = executor
        self._channel = channel
        self._stub = gchat_pb2_grpc.GroupChatStub(self._channel)
        self._name = name
        self._chat_join = threading.Event()
        self._chat_left = threading.Event()
        self._input_consumer_future = None
        self._message_consumer_future = None
        self._messages_rec: list[tuple[int, str, str]] = []
        self._send_count = 0
        self._emit_message = emit_message
        self._emit_stat = emit_stat

    @property
    def name(self) -> str:
        return self._name

    def _input_watcher(self) -> None:
        try:
            while not self._chat_left.is_set():
                if not select.select([sys.stdin], [], [], 0.001)[0]:
                    continue

                line = sys.stdin.readline()

                if line == "":
                    _LOGGER.debug("input ended")
                    break

                if INPUT_FROM_TERMINAL and self._emit_message:
                    # clears echoed user input
                    sys.stdout.write("\x1b[1A\x1b[2K")
                    sys.stdout.flush()

                line = line.rstrip()

                if line.startswith("/historial"):
                    self.get_history()
                    continue

                if line.startswith("/salir"):
                    self.disconnect()
                    break

                self.send_message(line)
        except Exception as e:
            _LOGGER.debug(f"input_watcher ended by exception: {e}")
        else:
            _LOGGER.debug("input_watcher ended normally")
            self.disconnect()

    def _message_watcher(self) -> None:
        try:
            while not self._chat_left.is_set():
                response = self._stub.Update(
                    request=gchat_pb2.UpdateRequest(name=self._name)
                )
                # if not response.messages or not self._emit_messages:
                if not response.messages or not self._emit_message:
                    time.sleep(0.2)
                    continue

                for message in response.messages:
                    self._messages_rec.append((message.ts, message.name, message.text))
                    print(util.fmt_message(message.ts, message.name, message.text))

        except grpc.RpcError as e:
            _LOGGER.debug(f"message_watcher ended by gRPC error: {e}")
        except KeyboardInterrupt:
            _LOGGER.debug("message_watcher ended by KeyboardInterrupt")
        else:
            _LOGGER.debug("message_watcher ended normally")

        self._chat_left.set()

    def join_chat(self) -> bool:
        response = self._stub.Connect(gchat_pb2.ConnectRequest(name=self._name))
        match response.state:
            case gchat_pb2.ConnectResponse.State.CONNECTED:
                self._chat_join.set()
            case _:
                _LOGGER.error(f"failed to join chat: {response.state}")
                self._chat_left.set()
                return False

        self._input_consumer_future = self._executor.submit(self._input_watcher)
        self._message_consumer_future = self._executor.submit(self._message_watcher)
        return True

    def disconnect(self) -> None:
        response = self._stub.Disconnect(gchat_pb2.DisconnectRequest(name=self._name))
        self._chat_left.set()

        _LOGGER.debug("disconnected from chat successfully")
        if self._emit_message:
            sys.stdout.write(
                util.fmt_message(
                    time.time_ns() // 1_000_000_000, "Server", response.message
                )
            )
            sys.stdout.flush()

    def send_message(self, text: str) -> None:
        self._send_count += 1
        request = gchat_pb2.SendMessageRequest(name=self._name, text=text)

        tick = time.time_ns()
        response = self._stub.SendMessage(request)
        now = time.time_ns()

        if self._emit_stat:
            total_time = (now - tick) / 1_000_000_000
            sys.stdout.write(
                f"{now // 1_000_000_000},{self._send_count},{total_time}\n"
            )
            sys.stdout.flush()

        if response.success:
            return

        self.disconnect()

    def get_history(self) -> None:
        response = self._stub.GetHistory(gchat_pb2.GetHistoryRequest())
        ts = time.time_ns() // 1_000_000_000

        path = pathlib.Path(f"./logs/historial/historial_{self._name}_{ts}.txt")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(response.history)
        if self._emit_message:
            sys.stdout.write(
                util.fmt_message(ts, "/historial", f"guardado en '{path}'\n")
            )
            sys.stdout.flush()

    def wait_leave(self) -> None:
        try:
            self._chat_left.wait()
        except KeyboardInterrupt:
            if not self._chat_left.is_set():
                self.disconnect()
                self._chat_left.set()


def main(args: list[str]) -> int:
    cfg = util.parse_client_args(args)

    _LOGGER.setLevel(cfg.log_level)

    target = "localhost:" + cfg.port
    username = cfg.username
    emit_messages = cfg.emit_messages
    emit_stats = cfg.emit_stats

    with ThreadPoolExecutor() as pool:
        with grpc.insecure_channel(target) as channel:
            chat = ChatUser(pool, channel, username, emit_messages, emit_stats)
            if chat.join_chat():
                _LOGGER.info("joined chat")
                chat.wait_leave()
                _LOGGER.info("left chat")
            else:
                _LOGGER.error("failed to join chat")

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
