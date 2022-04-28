#!/bin/bash
Err="Errsh.log"
:> $Err

if [ $# \< 1 ]
then
  echo "$(basename $0): Too few arguments" 2>> $Err
fi

File=$( find $1 -type f -executable -exec file {} + | grep ELF )
 
STDIFS=$IFS
IFS='"'

for file in $File
do
  echo "$file"
done

IFS=$STDIFS

sed -r "s/[^:]*:([^:]*:)?/$(basename $0):\1/g" $Err >&2
rm $Err
