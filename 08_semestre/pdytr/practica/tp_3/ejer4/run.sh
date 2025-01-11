#!/bin/bash

# ==============================================================================
# Script to handle two commands: 'gen-proto' and 'run'.
# - gen-proto: Generates Python gRPC protobuf files from .proto files.
# - run: Runs a benchmark testing script with various client counts and message sizes.
# ==============================================================================

VERBOSE=false

PROTOS_DIR="."
PROTOS_FILES="./protos/gchat.proto"

RUN_SCRIPT="./bench.sh"
RUN_CLIENTS=(8 32 64 128)
RUN_MESSAGE_SIZES=(100 1000 10000 100000 1000000)

gen_proto() {
    log_debug "Generating protobuf files..."

    if [ ! -f "$PROTOS_FILES" ]; then
        log_error "Protobuf file '$PROTOS_FILES' does not exist."
        return 1
    fi

    python -m grpc_tools.protoc \
        -I"$PROTOS_DIR" \
        --python_out="$PROTOS_DIR" \
        --pyi_out="$PROTOS_DIR" \
        --grpc_python_out="$PROTOS_DIR" \
        "$PROTOS_FILES"

    if [ $? -ne 0 ]; then
        log_error "Error generating protobuf files."
        return 1
    fi

    log_debug "Protobuf files generated successfully."
    return 0
}

run() {
    if [ ! -f $RUN_SCRIPT ]; then
        log_error "Error: '$RUN_SCRIPT' script not found in the current directory."
        return 1
    fi

    log_debug "Starting benchmark runs..."

    for clients in "${RUN_CLIENTS[@]}"; do
        for message_size in "${RUN_MESSAGE_SIZES[@]}"; do
            log_debug "Running benchmark with $clients clients and message size $message_size bytes..."

            if $RUN_SCRIPT "$clients" "$message_size"; then
                log_debug "Benchmark with $clients clients and message size $message_size completed successfully."
            else
                log_error "Error: Benchmark with $clients clients and message size $message_size failed."
                return 1
            fi
        done
    done

    log_debug "All benchmark runs completed successfully."

    return 0
}

usage() {
    cat << EOF
Usage: $0 <command> [options]

Commands:
  gen-proto    Generate gRPC Python files from protobuf files.
  run          Run the benchmark test scenarios with various client counts and message sizes.
  help         Show this help message.

Options:
  -v           Enable verbose mode.
  -h           Display this help message.

Examples:
  $0 gen-proto    # Generate proto files.
  $0 run          # Run the benchmark scenarios.
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
        'gen-proto')
            gen_proto
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
