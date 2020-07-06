#!/bin/bash -e
#Given a file specified in positional parameter 1, copy a byte-by-byte replica of 
#the file to the current directory. Prompts the user if the hash has changed in the process
 
if [ "$1" == "" ]; then
    printf "Get_Filecontent: You must specify a file to copy in position 1.\n"
    exit 1
fi

fileToCopy=$1
outputFilename=$(basename "$fileToCopy")
 
initHash=$(sha1sum $fileToCopy | awk '{ print $1 }')
dd if=$fileToCopy of=./$outputFilename
postHash=$(sha1sum ./$outputFilename | awk '{ print $1 }')

if [ "$initHash" != "$postHash" ]; then 
    printf "Hashes don't match.\n"
fi

