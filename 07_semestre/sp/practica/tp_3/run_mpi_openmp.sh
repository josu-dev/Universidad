#!/bin/bash

optimization=3

while getopts "o" opt; do
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
    echo "Usage: $0 [-o optimization] <script.c>"
    echo "Options:"
    echo "  -o optimization   Set the gcc optimization level (default: 3)."
    exit 1
fi

script=$1
binary_name=$(basename $script .c)_O$optimization

echo "Compiling $script with optimization $optimization and running tests..."

mpicc -o $binary_name -O$optimization -fopenmp $script
if [ $? -ne 0 ]; then
    exit 1
fi

mkdir -p logs

declare -A block_sizes
block_sizes["0512_2"]="32"
block_sizes["0512_4"]="16"
block_sizes["1024_2"]="64"
block_sizes["1024_4"]="32"
block_sizes["2048_2"]="64"
block_sizes["2048_4"]="64"
block_sizes["4096_2"]="64"
block_sizes["4096_4"]="64"

for msize in 0512 1024 2048 4096 ; do
    echo "Submitting batch jobs for $binary_name with msize=$msize..."
    cores_per_node=8
    for nodes in 2 4 ; do
        total_cores=$(printf "%03d" $((nodes * cores_per_node)))
        key="${msize}_${nodes}"
        for block_size in ${block_sizes[$key]} ; do
            output=./logs/out_${binary_name}_${total_cores}_${msize}_${block_size}
            error=./logs/err_${binary_name}_${total_cores}_${msize}_${block_size}
            sbatch -o $output -e $error -N $nodes --tasks-per-node=1 --exclusive --wrap "OMP_NUM_THREADS=$cores_per_node mpirun --bind-to none ./$binary_name $msize $block_size"
        done
    done
done
