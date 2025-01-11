#!/bin/bash

if [ ! $# -eq 1 ]; then
    echo "De un nombre de archivo como parametro"
    exit 1
fi

if [ -d $1 ]; then
    echo 'Es un directorio'
elif [ -f $1 ]; then
    echo 'Es un archivo'
else
    mkdir $1
fi