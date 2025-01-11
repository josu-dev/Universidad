#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo El primer argumento debe ser una extension
    exit 1
fi

if [[ $1 != .+(*) ]]; then
    ext="*.$1"
else
    ext="*$1"
fi

for directory in $(ls "$HOME/..")
do
    matches=$(find $ext "$HOME/../$directory")
    newLine=${directory};$(grep $matches wc -l)
    echo $newLine
done
