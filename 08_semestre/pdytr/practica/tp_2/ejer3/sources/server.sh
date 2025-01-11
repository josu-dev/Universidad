#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <report prefix>"
    exit 1
fi

gcc -o server ./server.c -lm
if [ $? -ne 0 ]; then
    echo "Error compiling server"
    exit 1
fi

REPORT_PREFIX=$1
ITERATIONS=100
PORT=3000
SAMPLE_START=1
SAMPLE_END=6

for ((e=SAMPLE_START; e<=SAMPLE_END; e++))
do
    exponent=$e
    report_fn=${REPORT_PREFIX}server_${exponent}.csv
    rm -f $report_fn
    echo "iteration,sended,recieved,expected_value,server_comm_time" > $report_fn
    
    echo "Running with exponent $exponent"
    for ((i=1; i<=ITERATIONS; i++))
    do
        PORT=$((PORT + 1))
        ./server "$PORT" "$exponent" "$i" >> $report_fn
    done
    echo "Done with exponent $exponent"
done
