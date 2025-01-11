import logging
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor

import grpc

import util
from protos import gchat_pb2, gchat_pb2_grpc


_LOGGER = logging.getLogger(__name__)

CHAT_WELCOME_MESSAGE = "Bienvenido {} al chat grupal ;)"
CHAT_LEFT_MESSAGE = "Adios {}, no vuelvas ;)"
CHAT_USER_EXISTS_MESSAGE = "El usuario '{}' ya existe, utilize otro ;)"


class GroupChatHandler(gchat_pb2_grpc.GroupChatServicer):
    def __init__(self, emit_stat: bool = False):
        self._lock = threading.RLock()
        self._clients: dict[str, int] = {}
        self._rec_mcache: list[tuple[int, str, str]] = []
        self._stat_enabled = emit_stat

    def _add_message(self, name: str, text: str) -> None:
        with self._lock:
            self._rec_mcache.append((time.time_ns() // 1_000_000_000, name, text))

    def _emit_stat(self) -> None:
        with self._lock:
            client_count = len(self._clients)

        sys.stdout.write(f"{time.time_ns() // 1_000_000_000},{client_count}\n")
        sys.stdout.flush()

    def Connect(
        self,
        request: gchat_pb2.ConnectRequest,
        context: grpc.ServicerContext,
    ) -> gchat_pb2.ConnectResponse:
        username = request.name
        with self._lock:
            if username in self._clients:
                _LOGGER.debug(f"client: '{username}' cannot connect, already exists")
                return gchat_pb2.ConnectResponse(
                    state=gchat_pb2.ConnectResponse.State.USER_EXISTS,
                    message=CHAT_USER_EXISTS_MESSAGE.format(username),
                )

            self._clients[username] = len(self._rec_mcache)

        _LOGGER.debug(f"client: '{username}' connected")

        self._add_message("Server", CHAT_WELCOME_MESSAGE.format(username))

        if self._stat_enabled:
            self._emit_stat()

        return gchat_pb2.ConnectResponse(
            state=gchat_pb2.ConnectResponse.State.CONNECTED,
            message=CHAT_LEFT_MESSAGE.format(username),
        )

    def SendMessage(
        self, request: gchat_pb2.SendMessageRequest, context: grpc.ServicerContext
    ) -> gchat_pb2.SendMessageResponse:
        _LOGGER.debug(f"'{request.name}' -> '{request.text[:64]}'")

        self._add_message(request.name, request.text)

        return gchat_pb2.SendMessageResponse(success=True)

    def Disconnect(
        self, request: gchat_pb2.DisconnectRequest, context: grpc.ServicerContext
    ) -> gchat_pb2.DisconnectResponse:
        username = request.name
        with self._lock:
            if username not in self._clients:
                _LOGGER.debug(f"client: '{username}' cannot disconnect, does not exist")
                return gchat_pb2.DisconnectResponse(
                    name=username, message=CHAT_LEFT_MESSAGE.format(username)
                )

            del self._clients[username]

        self._add_message("Server", CHAT_LEFT_MESSAGE.format(username))

        _LOGGER.debug(f"client: '{username}' disconnected")

        if self._stat_enabled:
            self._emit_stat()

        return gchat_pb2.DisconnectResponse(
            name=username, message=CHAT_LEFT_MESSAGE.format(username)
        )

    def Update(
        self,
        request: gchat_pb2.UpdateRequest,
        context: grpc.ServicerContext,
    ) -> gchat_pb2.UpdateResponse:
        username = request.name
        with self._lock:
            i = self._clients.get(username)
            if i is None or i >= len(self._rec_mcache):
                return gchat_pb2.UpdateResponse(messages=[])

            messages = [
                gchat_pb2.UserMessage(ts=ts, name=name, text=text)
                for ts, name, text in self._rec_mcache[i:]
            ]
            self._clients[username] = len(self._rec_mcache)

        return gchat_pb2.UpdateResponse(messages=messages)

    def GetHistory(
        self, request: gchat_pb2.GetHistoryRequest, context: grpc.ServicerContext
    ) -> gchat_pb2.GetHistoryResponse:
        with self._lock:
            history = "\n".join(util.fmt_message(*v) for v in self._rec_mcache) + "\n"
        return gchat_pb2.GetHistoryResponse(history=history)


def main(args: list[str]) -> int:
    cfg = util.parse_server_args(args)

    _LOGGER.setLevel(cfg.log_level)

    address = "localhost:" + cfg.port
    emit_stats = cfg.emit_stats

    with ThreadPoolExecutor() as pool:
        server = grpc.server(pool)  # type: ignore
        gchat_pb2_grpc.add_GroupChatServicer_to_server(
            GroupChatHandler(emit_stats), server
        )
        server.add_insecure_port(address)

        try:
            server.start()
            _LOGGER.info("server started on %s", address)
            server.wait_for_termination()
        except KeyboardInterrupt:
            server.stop(5)

        _LOGGER.info("server stopped")

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
