#!/bin/bash

set -e

filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

nasm -f elf64 -o $filename.o $1
ld $filename.o -o $filename
