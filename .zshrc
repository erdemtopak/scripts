export PATH=$PATH:~/Library/Android/sdk/platform-tools/
export PATH=$PATH:~/Library/Android/sdk/tools/
export PATH=$PATH:~/Library/Android/sdk/emulator/

alias remove_local_branches="git branch | grep -Ev 'main|develop' | xargs git branch -D"

alias gradle='./gradlew'
alias lint='gradle detekt ktlintcheck'

alias upDebug='./gradlew clean assembleDebug appDistributionUploadDebug'
alias upRelease='./gradlew clean assembleRelease appDistributionUploadRelease'


# Executes push command and takes one optional parameter for branch name
# @param branch_name specific branch name, default is current local branch name
# Executed command : git push origin branch_name
push () {
    if [ -z "$1" ]
      then
        input=$(git branch | grep '*')
        input=${input:2}
      else
        input=$1
    fi
    echo Pushing changes to \"$input\" branch
    git push origin $input
}

# Executes push force command and takes one optional parameter for branch name
# @param branch_name specific branch name, default is current local branch name
# Executed command : git push origin branch_name
pushf () {
    if [ -z "$1" ]
      then
        input=$(git branch | grep '*')
        input=${input:2}
      else
        input=$1
    fi
    echo Pushing changes to \"$input\" branch
    git push origin $input --force
}

# Takes a screenshot and saves it to the Desktop
ss() {
  local timestamp=$(date "+%Y-%m-%d at %H.%M.%S")
  local prevLocation=$(pwd)
  local filename="Device Screenshot ${timestamp}.png"
  cd ~/Desktop/
  adb exec-out screencap -p > $filename
  cd $prevLocation
}

# If you're working with android emulator, then use rec and get
# Firstly, execute rec, it will immediately start recording and kill the process (control + c)
# Then execute get, it will automatically gets the recorded video, converts it to a gif file and saves it to Desktop
# Converting videos to gif requires ffmpeg dependency, install it with `brew install ffmpeg`
alias rec="adb shell screenrecord /sdcard/video.mp4"
get() {
  local timestamp=$(date "+%Y-%m-%d at %H.%M.%S")
  local prevLocation=$(pwd)
  local videoFileName="Device Video ${timestamp}.mp4"
  local gifFileName="Device Gif ${timestamp}.gif"
  cd ~/Desktop/
  adb pull /sdcard/video.mp4
  adb shell rm /sdcard/video.mp4
  ffmpeg -i video.mp4 -vf "fps=10,scale=360:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $gifFileName
  mv video.mp4 $videoFileName
  cd $prevLocation
}

# If you're working with real device via scrcpy, then use rec2 and get2
# Firstly, execute rec2, it will immediately start recording and kill the process (control + c)
# Then execute get2, it will automatically gets the recorded video, converts it to a gif file and saves it to Desktop
# Converting videos to gif requires ffmpeg dependency, install it with `brew install ffmpeg`
alias rec2="scrcpy --record video.mp4"
get2() {
  local timestamp=$(date "+%Y-%m-%d at %H.%M.%S")
  local prevLocation=$(pwd)
  local videoFileName="Device Video ${timestamp}.mp4"
  local gifFileName="Device Gif ${timestamp}.gif"
  ffmpeg -i video.mp4 -vf "fps=10,scale=360:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $gifFileName
  mv video.mp4 ~/Desktop/$videoFileName
  mv $gifFileName ~/Desktop/$gifFileName
}