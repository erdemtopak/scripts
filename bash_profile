#export PATH="$PATH:/Users/topake/IOSProjects/apache-maven-3.0.5/bin:/usr/local/opt/go/libexec/bin"
export PATH=$PATH:~/Library/Android/sdk/platform-tools/
export PATH=$PATH:~/Library/Android/sdk/tools/
export PATH=$PATH:~/Library/Android/sdk/build-tools/25.0.1/
export ANDROID_HOME="/Users/topake/Library/Android/sdk/"
export JAVA_HOME=$(/usr/libexec/java_home)
alias gradle="./gradlew"
export GOPATH="/Users/topake/go"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

ssh-add -K ~/.ssh/id_rsa

export NODE_PATH='/usr/local/lib/node_modules'

cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# Executes push command and takes one optional parameter
# @param branch_name specific branch name, default is current local branch name
# Executed command : git push origin HEAD:refs/for/branch_name
push () {
    if [ -z "$1" ]
      then
        input=$(git branch | grep '*')
        input=${input:2}
      else
        input=$1
    fi
    echo Pushing changes to \"$input\" branch
    git push origin HEAD:refs/for/$input
}

# Executes rebase command and takes one optional parameter
# @param branch_name specific branch name, default is current local branch name
# Executed command : git rebase origin/branch_name
rebase() {
    if [ -z "$1" ]
      then
        input=$(git branch | grep '*')
        input=${input:2}
      else
        input=$1
    fi
    echo Rebasing to origin/\"$input\" branch
    git rebase -i origin/$input
}

# Switches to the branch if specified and pulls changes with rebase option, takes one optional parameter
# @param branch_name specific branch name, default is current local branch name
pull () {
    git checkout $1
    git pull --rebase
}

# Firstly stashes changes
# Then switches to the branch if specified and pulls changes with rebase option, takes one optional parameter
# Finally applies previous stash 
# @param branch_name specific branch name, default is current local branch name
pulls () {
    git stash
    git checkout $1
    git pull --rebase 
    git stash pop
}

#Restart android debug bridge service
adbrestart () {
    adb kill-server
    adb start-server
}
