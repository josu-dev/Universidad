#!/bin/bash

# ==============================================================================
# Script to handle two commands: 'gen-proto'.
# - gen-proto: Generates Python gRPC protobuf files from .proto files.
# ==============================================================================

VERBOSE=false

PROTOS_DIR="."
PROTOS_FILES="./protos/gchat.proto"

gen_proto() {
    log_debug "Generating protobuf files..."

    if [ ! -f "$PROTOS_FILES" ]; then
        log_error "Protobuf files '$PROTOS_FILES' do not exist."
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

usage() {
    cat << EOF
Usage: $0 <command> [options]

Commands:
  gen-proto    Generate gRPC Python files from protobuf files.
  help         Show this help message.

Options:
  -v           Enable verbose mode.
  -h           Display this help message.

Examples:
  $0 gen-proto    # Generate proto files
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
