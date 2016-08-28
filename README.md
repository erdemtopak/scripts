# Useful-Git-Scripts
Useful Git Scripts

If you work with more than one remote repository, this bash script will save time for you.
```
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
```

Rebase Version
```
git rebase -i origin/$input
```

Example use:
```
push test    # will be executed as git push origin HEAD:refs/for/test
push         # will be executed as git push origin HEAD:refs/for/current_local_branch_name
```
