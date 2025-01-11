#
# HAND WRITTEN, EDIT CAREFULLY
#
# Update it every time proto is changed :D
"""Client and server classes corresponding to protobuf-defined services."""
import typing as t

import grpc

import protos.gchat_pb2

GRPC_GENERATED_VERSION = "1.66.2"
GRPC_VERSION = grpc.__version__
_version_not_supported = False

class GroupChatStub(object):
    """The greeting service definition."""

    Connect: grpc.UnaryUnaryMultiCallable[
        protos.gchat_pb2.ConnectRequest,
        protos.gchat_pb2.ConnectResponse,
    ]
    Disconnect: grpc.UnaryUnaryMultiCallable[
        protos.gchat_pb2.DisconnectRequest,
        protos.gchat_pb2.DisconnectResponse,
    ]
    SendMessage: grpc.UnaryUnaryMultiCallable[
        protos.gchat_pb2.SendMessageRequest,
        protos.gchat_pb2.SendMessageResponse,
    ]
    GetHistory: grpc.UnaryUnaryMultiCallable[
        protos.gchat_pb2.GetHistoryRequest,
        protos.gchat_pb2.GetHistoryResponse,
    ]
    Update: grpc.UnaryUnaryMultiCallable[
        protos.gchat_pb2.UpdateRequest,
        protos.gchat_pb2.UpdateResponse,
    ]

    def __init__(self, channel: grpc.Channel) -> None:
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """

class GroupChatServicer(object):
    """The greeting service definition."""

    def Connect(
        self,
        request: protos.gchat_pb2.ConnectRequest,
        context: grpc.ServicerContext,
    ) -> protos.gchat_pb2.ConnectResponse:
        """Sends a greeting"""
        ...

    def Disconnect(
        self,
        request: protos.gchat_pb2.DisconnectRequest,
        context: grpc.ServicerContext,
    ) -> protos.gchat_pb2.DisconnectResponse:
        """Sends another greeting"""
        ...

    def SendMessage(
        self,
        request: protos.gchat_pb2.SendMessageRequest,
        context: grpc.ServicerContext,
    ) -> protos.gchat_pb2.SendMessageResponse:
        """Missing associated documentation comment in .proto file."""
        ...

    def GetHistory(
        self,
        request: protos.gchat_pb2.GetHistoryRequest,
        context: grpc.ServicerContext,
    ) -> protos.gchat_pb2.GetHistoryResponse:
        """Missing associated documentation comment in .proto file."""
        ...

    def Update(
        self,
        request: protos.gchat_pb2.UpdateRequest,
        context: grpc.ServicerContext,
    ) -> protos.gchat_pb2.UpdateResponse:
        """Missing associated documentation comment in .proto file."""
        ...

def add_GroupChatServicer_to_server(
    servicer: GroupChatServicer, server: grpc.Server
) -> None: ...
