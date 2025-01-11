#!/bin/bash

for script in "quadratic1.c" "quadratic2.c" quadratic3.c; do
    for olevel in 2; do
        name=$(basename $script .c)_O$olevel
        echo "Compiling $script with optimization $olevel..."
        gcc -o $name -O$olevel $script -lm 
        if [ $? -ne 0 ]; then
            exit 1
        fi
        echo "Running $name..."
        "./$name"
    done
done
