#!/bin/bash

script=$1
optimization=${2:-3}
name=$(basename $script .c)_O$optimization

echo "Compiling $script with optimization $optimization and running tests..."

gcc -o $name -O$optimization $script
if [ $? -ne 0 ]; then
    exit 1
fi

for msize in 4096 ; do
    echo "Running $name with msize=$msize..."
    for bsize in 4 8 16 32 64 128 ; do
        ./$name $msize $bsize
    done
done
