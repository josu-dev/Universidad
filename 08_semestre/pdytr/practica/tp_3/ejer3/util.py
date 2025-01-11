import argparse
import os
import stat
import time
import typing as t


DATE_TIME_FORMAT = "%Y%m%d - %H:%M:%S"


def fmt_message(ts: int, name: str, text: str) -> str:
    return "[{}] {}: {}".format(
        time.strftime(DATE_TIME_FORMAT, time.localtime(ts)),
        name,
        text,
    )


def input_is_from_terminal() -> bool:
    mode = os.fstat(0).st_mode
    if stat.S_ISFIFO(mode):
        return False

    if stat.S_ISREG(mode):
        return False

    return True


type LogLevel = t.Literal["CRITICAL", "ERROR", "WARNING", "INFO", "DEBUG", "NOTSET"]


class ServerChatArgs(argparse.Namespace):
    port: str
    emit_stats: bool
    log_level: LogLevel


def parse_server_args(rargs: list[str]) -> ServerChatArgs:
    parser = argparse.ArgumentParser(description="gRPC group chat server")

    parser.add_argument(
        "-p",
        "--port",
        type=str,
        default="50051",
        help="Port to bind the server to (default: 50051)",
    )

    stats_group = parser.add_mutually_exclusive_group()
    stats_group.add_argument(
        "-s", "--emit-stats", action="store_true", help="Enable statistics"
    )
    stats_group.add_argument(
        "-S",
        "--no-stats",
        action="store_false",
        dest="emit_stats",
        help="Disable statistics (default)",
    )

    parser.add_argument(
        "-l",
        "--log-level",
        type=str,
        choices=["CRITICAL", "ERROR", "WARNING", "INFO", "DEBUG", "NOTSET"],
        default="NOTSET",
        help="Set the logging level (default: NOTSET)",
    )

    args = parser.parse_args(rargs, namespace=ServerChatArgs())

    args.port = args.port.strip() or "50051"
    if not args.port.isdigit():
        parser.error("Port must be a valid number (1024-65535)")

    return args


class ClientChatArgs(argparse.Namespace):
    port: str
    emit_stats: bool
    emit_messages: bool
    log_level: LogLevel
    username: str


def parse_client_args(rargs: list[str]) -> ClientChatArgs:
    parser = argparse.ArgumentParser(description="gRPC group chat client")

    parser.add_argument(
        "-p",
        "--port",
        type=str,
        default="50051",
        help="Port to connect to (default: 50051)",
    )

    stats_group = parser.add_mutually_exclusive_group()
    stats_group.add_argument(
        "-s", "--emit-stats", action="store_true", help="Enable statistics"
    )
    stats_group.add_argument(
        "-S",
        "--no-stats",
        action="store_false",
        dest="emit_stats",
        help="Disable statistics (default)",
    )

    message_group = parser.add_mutually_exclusive_group()
    message_group.add_argument(
        "-m",
        "--emit-messages",
        action="store_true",
        default=True,
        help="Enable messages (default)",
    )
    message_group.add_argument(
        "-M",
        "--no-messages",
        action="store_false",
        dest="emit_messages",
        help="Disable messages",
    )

    parser.add_argument(
        "-l",
        "--log-level",
        type=str,
        choices=["CRITICAL", "ERROR", "WARNING", "INFO", "DEBUG", "NOTSET"],
        default="NOTSET",
        help="Set the logging level (default: NOTSET)",
    )

    parser.add_argument("username", type=str, help="The username to connect with")

    args = parser.parse_args(rargs, namespace=ClientChatArgs())

    args.username = args.username.strip()
    if not args.username:
        parser.error("Username cannot be empty")

    args.port = args.port.strip() or "50051"
    if not args.port.isdigit():
        parser.error("Port must be a valid number (1024-65535)")

    return args
