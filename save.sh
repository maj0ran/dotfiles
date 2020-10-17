#!/usr/bin/bash

FILES=$(find . -type f | grep -E -v ".git/|README|save" | sed s#^./##)

for FILE in $FILES
do
	cp $HOME'/'$FILE $FILE
done
