#!/bin/bash

gcc -o client ./client.c -lm
if [ $? -ne 0 ]; then
    echo "Error compiling client"
    exit 1
fi

gcc -o server ./server.c -lm
if [ $? -ne 0 ]; then
    echo "Error compiling server"
    exit 1
fi

ITERATIONS=100
PORT=4000
SAMPLE_START=1
SAMPLE_END=6

for ((e=SAMPLE_START; e<=SAMPLE_END; e++))
do
    EXPONENT=$e
    rm -f out_client_$EXPONENT.csv
    rm -f out_server_$EXPONENT.csv
    echo "iteration,sended,recieved" > out_client_$EXPONENT.csv
    echo "iteration,sended,recieved" > out_server_$EXPONENT.csv
    
    echo "Running with exponent $EXPONENT"
    for ((i=1; i<=ITERATIONS; i++))
    do
        PORT=$((PORT + 1))
        ./server "$PORT" "$EXPONENT" "$i" >> out_server_$EXPONENT.csv &
        SERVER_PID=$!

        sleep 0.010

        ./client "127.0.0.1" "$PORT" "$EXPONENT" "$i" >> out_client_$EXPONENT.csv &
        CLIENT_PID=$!

        wait $SERVER_PID
        wait $CLIENT_PID
    done
    echo "Done with exponent $EXPONENT"
done

zip c_outputs.zip out_client_*.csv out_server_*.csv
