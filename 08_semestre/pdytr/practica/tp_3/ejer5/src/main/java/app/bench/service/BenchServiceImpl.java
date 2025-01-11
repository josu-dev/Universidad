package app.bench.service;

import app.bench.*;
import app.bench.BenchServiceGrpc.BenchServiceImplBase;
import app.bench.BenchServiceProto.*;
import com.google.protobuf.ByteString;
import io.grpc.stub.StreamObserver;

public class BenchServiceImpl extends BenchServiceImplBase {
    private int bufferSize;
    private int iteration;
    private byte[] sendData;

    public BenchServiceImpl(int iteration, int bufferSize) {
        this.iteration = iteration;
        this.bufferSize = bufferSize;
        this.sendData = Utils.setupBuffer(12, bufferSize);
    }

    @Override
    public void ping(PingRequest request, StreamObserver<PingResponse> responseObserver) {
        PingResponse response = PingResponse.newBuilder().setData(ByteString.copyFrom(sendData)).build();
        
        responseObserver.onNext(response);
        responseObserver.onCompleted();

        byte[] receivedData = request.getData().toByteArray();
        boolean readIntegrity = receivedData.length == this.bufferSize;

        System.out.print(String.format(
            "%s,%s,%s,%s,0\n",
            this.iteration,
            this.bufferSize,
            receivedData.length,
            readIntegrity ? "true" : "false"
        ));
    }
}
