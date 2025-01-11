#!/bin/bash

script=$1
optimization=${2:-3}
name=$(basename $script .c)_O$optimization

echo "Compiling $script with optimization $optimization and running tests..."

gcc -o $name -O$optimization $script
if [ $? -ne 0 ]; then
    exit 1
fi

for msize in 512 1024 2048 4096 ; do
    echo "Running $name with msize=$msize..."
    output=./logs/out_${name}_${msize}
    error=./logs/err_${name}_${msize}
    sbatch -o $output -e $error -N 1 --exclusive --wrap "./$name $msize"
done
