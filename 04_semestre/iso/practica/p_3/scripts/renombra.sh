#!/bin/bash
if [[ $# -lt 1 || ! -d $1 ]]; then
    echo "Primer parametro no es un directorio"
    exit 1
fi
if [[ $# -lt 3 ]]; then
    echo "No ingreso argumentos"
    exit 1
fi

cd $1
files=$(ls .)

if [[ $2 == '-a' ]]; then
    for file in $files
    do
        echo $file
        mv "${basedir}${file}" "${basedir}${file}${3}"
    done
elif [[ $2 == '-b' ]]; then
    for file in $files 
    do
        echo $file
        mv "${basedir}${file}" "${basedir}${3}${file}"
    done
else
    echo "El segundo argumento debe ser -a | -b"
fi

# basedir=$(pwd)\/${1}
# files=$(ls "$basedir")
