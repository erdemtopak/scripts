#!/bin/bash
if [ -z "$1" ]
  then
    input=$(git branch | grep '*')
    input=${input:2}
  else
 	input=$1
fi
echo Pushing changes to \"$input\" branch
git push origin HEAD:refs/for/$input