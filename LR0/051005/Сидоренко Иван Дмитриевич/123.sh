
#!/bin/bash

if [ -n "$1" ]
then
{
gcc -Wall -o "${1%.*}.out" $1
} &&	{
./"${1%.*}.out" $@
}
else
echo "compile error">&2
fi
