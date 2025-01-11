#!/bin/bash

optimization=3

while getopts "o:tnt" opt; do
  case ${opt} in
    o )
      optimization=$OPTARG
      if [[ $optimization -lt 0 || $optimization -gt 3 ]]; then
        echo "Invalid gcc optimization level: $optimization. It should be between 0 and 3."
        exit 1
      fi
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done

shift $((OPTIND -1))

if [ $# -lt 1 ]; then
    echo "Usage: $0 [-o optimization] [-t | -nt] <script.c>"
    echo "Options:"
    echo "  -o optimization   Set the gcc optimization level (default: 3)."
    exit 1
fi

script=$1
binary_name=$(basename $script .c)_O$optimization

echo "Compiling $script with optimization $optimization and running tests..."

gcc -o $binary_name -O$optimization -pthread $script
if [ $? -ne 0 ]; then
    exit 1
fi

mkdir -p logs

for msize in 0512 1024 2048 4096 ; do
    echo "Submitting batch jobs for $binary_name with msize=$msize..."
    # for bsize in 004 008 016 032 064 128 ; do
    for bsize in 128 ; do
        for threads in 2 4 8 ; do
            output=./logs/out_${binary_name}_${msize}_${bsize}_${threads}
            error=./logs/err_${binary_name}_${msize}_${bsize}_${threads}
            sbatch -o $output -e $error -N 1 --exclusive --wrap "./$binary_name $msize $bsize $threads"
        done
    done
done
