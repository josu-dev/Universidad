#!/bin/bash

# ==============================================================================
# Script to handle two commands: 'compile' and 'run'.
# - compile: Generates protobuf files and compiles the project.
# - run: Executes a series of test scenarios with data of varying sizes.
# ==============================================================================

VERBOSE=false

CLASS_PATH_FILE=".temp.classpath"

RUN_REPORT_DIR="./logs/"
RUN_ITERATIONS=100
RUN_PORT=16000
RUN_SIZE_START=1
RUN_SIZE_END=6
RUN_CLIENT_CLASS="app.bench.client.BenchClient"
RUN_SERVER_CLASS="app.bench.server.BenchServer"

compile() {
    log_debug "Compiling the project..."

    mvn compile
    mvn dependency:build-classpath -Dmdep.outputFile="$CLASS_PATH_FILE"

    if [ $? -ne 0 ]; then
        log_error "Error compiling the project."
        return 1
    fi

    log_debug "Compiling the project completed successfully."
    return 0
}

run() {
    log_debug "Running the test scenarios..."

    mkdir -p "$RUN_REPORT_DIR"

    server_error_fn="${RUN_REPORT_DIR}server_err.txt"
    client_error_fn="${RUN_REPORT_DIR}client_err.txt"
    > "$server_error_fn"
    > "$client_error_fn"

    if [ ! -f "$CLASS_PATH_FILE" ]; then
        mvn dependency:build-classpath -Dmdep.outputFile="$CLASS_PATH_FILE"
    fi
    
    classpath=target/classes:$(cat "$CLASS_PATH_FILE")

    for ((data_size=RUN_SIZE_START; data_size<=RUN_SIZE_END; data_size++)); do
        server_report_fn="${RUN_REPORT_DIR}server_${data_size}.csv"
        client_report_fn="${RUN_REPORT_DIR}client_${data_size}.csv"
        rm -f "$server_report_fn"
        rm -f "$client_report_fn"

        echo "iteration,sent,received,expected_value,server_comm_time" > "$server_report_fn"
        echo "iteration,sent,received,expected_value,client_comm_time" > "$client_report_fn"

        log_debug "Running with data size $data_size"

        for ((i=1; i<=RUN_ITERATIONS; i++)); do
            RUN_PORT=$((RUN_PORT + 1))

            java -cp "$classpath" $RUN_SERVER_CLASS "$RUN_PORT" "$data_size" "$i" >> "$server_report_fn" 2>> "$server_error_fn" &
            SERVER_PID=$!

            sleep 0.05

            java -cp "$classpath" $RUN_CLIENT_CLASS "localhost" "$RUN_PORT" "$data_size" "$i" >> "$client_report_fn" 2>> "$client_error_fn" &
            CLIENT_PID=$!

            wait "$CLIENT_PID"
            kill -9 "$SERVER_PID" 2> /dev/null
            wait "$SERVER_PID" 2> /dev/null
        done
    done

    log_debug "Completed test scenarios for sizes $RUN_SIZE_START to $RUN_SIZE_END"
    return 0
}

usage() {
    cat << EOF
Usage: $0 <command> [options]

Commands:
  compile      Generate protobuf and compile the project.
  run          Run the test scenarios.
  help         Show this help message.

Options:
  -v           Enable verbose mode.
  -h           Display this help message.

Examples:
  $0 compile      # Generate protobuf and compile the project
  $0 run          # Run the test scenarios
EOF

    return 0
}

log_debug() {
    if [ "$VERBOSE" = true ]; then
        echo "$1"
    fi
}

log_error() {
    echo "$1" >&2
}

main() {
    while getopts ":vh" opt; do
        case "$opt" in
            v)
                VERBOSE=true
                ;;
            h)
                usage
                return 0
                ;;
            \?)
                log_error "Invalid option: -$OPTARG. Use -h for help."
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    if [ $# -lt 1 ]; then
        log_error "No command provided. Use '$0 help' for usage."
        return 1
    fi

    COMMAND="$1"
    shift
    case "$COMMAND" in
        'compile')
            compile
            return $?
            ;;
        'run')
            run
            return $?
            ;;
        'help')
            usage
            return 0
            ;;
        *)
            log_error "Invalid command: $COMMAND. Use '$0 help' for usage."
            return 1
            ;;
    esac
}

main "$@"
exit $?
