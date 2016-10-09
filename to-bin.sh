#!/bin/bash

set -e

filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

nasm -g -f elf64 -o bin/$filename.o $1
ld bin/$filename.o -o bin/$filename
