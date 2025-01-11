package app.bench.client;

import app.bench.BenchServiceGrpc;
import app.bench.BenchServiceProto.*;
import app.bench.Utils;
import com.google.protobuf.ByteString;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;

public class BenchClient {
	public static void main(String[] args) {
		if ((args.length != 4) || (Integer.valueOf(args[1]) <= 0) || (Integer.valueOf(args[2]) <= 0)
				|| (Integer.valueOf(args[3]) <= 0)) {
			System.out.println("5 arguments needed: host port exponent iteration");
			System.exit(1);
		}

		String host = args[0];
		int port = Integer.valueOf(args[1]);
		int exponent = Integer.valueOf(args[2]);
		int iteration = Integer.valueOf(args[3]);

		int bufferSize = (int) Math.pow(10, exponent);
		byte[] sendData = Utils.setupBuffer(0, bufferSize);

		ManagedChannel channel = ManagedChannelBuilder.forAddress(host, port).usePlaintext().build();
		BenchServiceGrpc.BenchServiceBlockingStub stub = BenchServiceGrpc.newBlockingStub(channel);
		
        PingRequest pingRequest = PingRequest.newBuilder().setData(ByteString.copyFrom(sendData)).build();

		long tick = System.nanoTime();
		PingResponse res1 = stub.ping(pingRequest);
		long elapsed1 = System.nanoTime() - tick;

		tick = System.nanoTime();
		PingResponse res2 = stub.ping(pingRequest);
		long elapsed2 = System.nanoTime() - tick;

		channel.shutdown();

		byte[] receivedData = res2.getData().toByteArray();
		boolean readIntegrity = receivedData.length == bufferSize;

		System.out.print(String.format("%s,%s,%s,%s,%.6f\n", iteration, bufferSize, bufferSize,
			readIntegrity ? "true" : "false", elapsed1 / 1_000_000_000.0));
        System.out.print(String.format("%s,%s,%s,%s,%.6f\n", iteration, bufferSize, bufferSize,
			readIntegrity ? "true" : "false", elapsed2 / 1_000_000_000.0));
	}
}
