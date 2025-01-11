package app.bench.server;

import app.bench.service.BenchServiceImpl;
import io.grpc.Server;
import io.grpc.ServerBuilder;
import java.io.IOException;

public class BenchServer {
    public static void main(String[] args) throws IOException, InterruptedException {
        if ((args.length != 3) || (Integer.valueOf(args[0]) <= 0) || (Integer.valueOf(args[1]) <= 0) || (Integer.valueOf(args[2]) <= 0)) {
            System.out.println("3 arguments needed: port exponent iteration");
            System.exit(1);
        }

        int port = Integer.valueOf(args[0]);
        int exponent = Integer.valueOf(args[1]);
        int iteration = Integer.valueOf(args[2]);

        int bufferSize = (int)Math.pow(10, exponent);
        Server server = ServerBuilder.forPort(port)
            .addService(new BenchServiceImpl(iteration, bufferSize))
            .build();

        System.err.println("Starting server...");

        server.start();
        System.err.println(String.format("Server started on port %d", port));

        server.awaitTermination();
    }
}
