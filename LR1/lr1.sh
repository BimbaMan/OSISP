#!/bin/bash

File="INFO.log"

:> $File

if [ $# \< 3 ]
then
	echo "$(basename $0): Too few arguments" >&2
	exit 1
fi

A=$( find $(readlink -f $1) -size +$2c -size -$3c -type f -printf '%p"' 2>> $File)
B=$( find $(readlink -f $1) -size +$2c -size -$3c -type f -printf '%p"' 2>> $File)

E=0

STDIFS=$IFS
IFS='"'
for file in $A
do
	for file2 in $B
	do
		if ( cmp -s "$file" "$file2" 2>> $File )  && [ "$file" != "$file2" ]
			then
				echo "$file = $file2"
				E=$(($E+1)) 
		fi
	done
done
	if  [ "$E" -eq "0" ] 
	then
	echo "No result" >&2
	fi
IFS=$STDIFS

sed -r "s/[^:]*:([^:]*:)?/$(basename $0):\1/g" $File >&2
rm $File
