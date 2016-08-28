#!/bin/bash
if [ -z "$1" ]
  then
    input=$(git branch | grep '*')
    input=${input:2}
  else
 	input=$1
fi
echo Rebasing to origin/\"$input\" branch
git rebase -i origin/$input
