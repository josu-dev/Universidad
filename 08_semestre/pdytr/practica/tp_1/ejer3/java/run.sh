#!/bin/bash

javac ./Client.java Utils.java
if [ $? -ne 0 ]; then
    echo "Error compiling client"
    exit 1
fi

javac ./Server.java Utils.java
if [ $? -ne 0 ]; then
    echo "Error compiling server"
    exit 1
fi

ITERATIONS=100
PORT=3000
SAMPLE_START=1
SAMPLE_END=7

for ((e=SAMPLE_START; e<=SAMPLE_END; e++))
do
    EXPONENT=$e
    rm -f out_client*_$EXPONENT.csv
    rm -f out_server*_$EXPONENT.csv
    echo "iteration,send_bytes,read_bytes,read_iterations,read_integrity,client_comm_time" > out_client_$EXPONENT.csv
    echo "iteration,send_bytes,read_bytes,read_iterations,read_integrity,server_comm_time" > out_server_$EXPONENT.csv
    
    echo "Running with exponent $EXPONENT"
    for ((i=1; i<=ITERATIONS; i++))
    do
        PORT=$((PORT + 1))
        java -cp . Server "$PORT" "$EXPONENT" "$i" >> out_server_$EXPONENT.csv &
        SERVER_PID=$!

        sleep 0.010

        java -cp . Client "127.0.0.1" "$PORT" "$EXPONENT" "$i" >> out_client_$EXPONENT.csv &
        CLIENT_PID=$!

        wait $SERVER_PID
        wait $CLIENT_PID
    done
    echo "Done with exponent $EXPONENT"
done

zip java_outputs.zip out_client_*.csv out_server_*.csv
