#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <report prefix> <server ip>"
    exit 1
fi

gcc -o client ./client.c -lm
if [ $? -ne 0 ]; then
    echo "Error compiling client"
    exit 1
fi

REPORT_PREFIX=$1
SERVER_IP=$2
ITERATIONS=100
PORT=3000
SAMPLE_START=1
SAMPLE_END=6

for ((e=SAMPLE_START; e<=SAMPLE_END; e++))
do
    exponent=$e
    report_fn=${REPORT_PREFIX}client_${exponent}.csv
    rm -f $report_fn
    echo "iteration,sended,recieved,expected_value,client_comm_time" > $report_fn
   
    echo "Running with exponent $exponent"
    for ((i=1; i<=ITERATIONS; i++))
    do
        PORT=$((PORT + 1))
        sleep 0.010
        ./client "$SERVER_IP" "$PORT" "$exponent" "$i" >> $report_fn   
    done
done
