#!/bin/bash
if [ $# -lt 3 ]; then
    echo "faltaron parametros"
    exit 1
fi
echo "$(expr "$@")"