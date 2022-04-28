#!/bin/bash

name=$(basename -- "$1")
name="${name%.*}.out"

if gcc $1 -o $name; then
	shift 1;
	./$name $@;
else
	echo "compile error">&2;
fi
