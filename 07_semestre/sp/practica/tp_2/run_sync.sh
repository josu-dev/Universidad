#!/bin/bash

script=$1
optimization=${2:-3}
name=$(basename $script .c)_O$optimization

echo "Compiling $script with optimization $optimization and running tests..."

gcc -o $name -O$optimization -pthread $script
if [ $? -ne 0 ]; then
    exit 1
fi

mkdir -p logs

# for msize in 512 1024 2048 4096 ; do
for msize in 512 2048 ; do
    echo "Running $name with msize=$msize..."
    # for bsize in 4 8 16 32 64 128 ; do
    for bsize in 16 128 ; do
        for threads in 2 4 8 ; do
            # output=./logs/out_${name}_${msize}_${bsize}_${threads}
            # error=./logs/err_${name}_${msize}_${bsize}_${threads}
            # sbatch -o $output -e $error -N 1 --exclusive --wrap "./$name $msize $bsize $threads"
            ./$name $msize $bsize $threads
        done
    done
done
