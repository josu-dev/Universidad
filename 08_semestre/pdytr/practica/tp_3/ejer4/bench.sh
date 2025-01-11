#!/bin/bash

CLIENTS=$1
MESSAGE_SIZE=$2
MESSAGE_COUNT=${3:-100}
UPDATE_INTERVAL=${4:-0}

GRPC_CLIENT_SCRIPT="client.py"
GRPC_SERVER_SCRIPT="server.py"
GENERATE_INPUT_SCRIPT="gen_input.sh"

LOG_DIR="logs/$CLIENTS/$MESSAGE_SIZE/"
RESULT_LOG_DIR="$LOG_DIR/result"
CLIENT_LOG_DIR="$LOG_DIR/client"
SERVER_LOG_DIR="$LOG_DIR/server"

SERVER_MONITOR_LOG="$RESULT_LOG_DIR/server_metrics.csv"

get_free_port() {
    while : ; do
        port=$(( ( RANDOM % 64512 ) + 1024 ))

        if ! ss -ltn | grep -q ":$port "; then
            echo $port
            return
        fi
    done
}

reset() {
    rm -rf $LOG_DIR
    mkdir -p $RESULT_LOG_DIR $CLIENT_LOG_DIR $SERVER_LOG_DIR
    echo "ts,cpu_usage(%),memory_usage(%),connections" > "$SERVER_MONITOR_LOG"

    BENCH_PORT=$(get_free_port)
}


cleanup() {
    for pid in "${CLIENT_PIDS[@]}"; do
        kill -9 $pid
    done
    echo "Stopped all clients."

    kill -9 $SERVER_PID
    echo "Stopped server (PID $SERVER_PID)."

    kill -9 $MONITOR_PID
    echo "Stopped monitoring server metrics (PID $MONITOR_PID)."

    exit 0
}

wait_process() {
    for pid in "${CLIENT_PIDS[@]}"; do
        wait $pid > /dev/null 2>&1
    done

    kill -9 $SERVER_PID
    kill -9 $MONITOR_PID
    
    wait $SERVER_PID > /dev/null 2>&1
    wait $MONITOR_PID > /dev/null 2>&1
}

server_monitor_metrics() {
    echo "Monitoring CPU, memory, and file descriptors of server (PID $SERVER_PID)..."
    
    while true; do
        ts=$(date +%s)

        cpu_memory=$(ps --no-headers -p $SERVER_PID -o %cpu,%mem=)
        cpu_usage=$(echo $cpu_memory | awk '{print $1}')
        memory_usage=$(echo $cpu_memory | awk '{print $2}')

        connections=$(tail -n 1 "$SERVER_LOG_DIR/server_out.log" | awk -F',' '{print $2}')
        if ! [[ "$connections" =~ ^[0-9]+$ ]]; then
            connections=0
        fi

        echo "$ts,$cpu_usage,$memory_usage,$connections" >> "$SERVER_MONITOR_LOG"

        sleep $UPDATE_INTERVAL
    done
}

start_server() {
    output_fn="$SERVER_LOG_DIR/server_out.log"
    error_fn="$SERVER_LOG_DIR/server_err.log"
    python3 -W ignore $GRPC_SERVER_SCRIPT -p $BENCH_PORT -s > $output_fn 2> $error_fn &
    SERVER_PID=$!
    echo "Server running with PID $SERVER_PID"
}

start_server_metrics() {
    server_monitor_metrics &
    MONITOR_PID=$!
    echo "Server metrics monitoring started with PID $MONITOR_PID"
}

start_clients() {
    CLIENT_PIDS=()
    for ((i=1; i<=CLIENTS; i++)); do
        USERNAME="user_$i"
        output_fn="$CLIENT_LOG_DIR/${USERNAME}_out.log"
        error_fn="$CLIENT_LOG_DIR/${USERNAME}_err.log"
        # echo $MESSAGE_COUNT
        # Start the client in the background, pipe input from feed_input.sh, and redirect stdout and stderr to client log files
        ./$GENERATE_INPUT_SCRIPT $UPDATE_INTERVAL $MESSAGE_SIZE $USERNAME $MESSAGE_COUNT | python3 -W ignore $GRPC_CLIENT_SCRIPT -p $BENCH_PORT -s -M $USERNAME > $output_fn 2> $error_fn &	

        # Store the client PID
        CLIENT_PIDS+=($!)
    done
}

run() {
    reset
    
    trap cleanup SIGINT SIGTERM

    start_server
    start_server_metrics
    
    sleep 3

    start_clients
    
    wait_process
    
    exit 0
}

run
