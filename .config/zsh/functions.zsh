# TMUX function
runworkspaces () {
    tmux -2 kill-server
    tmux -2 new-session -s "mySession" -d
    tmux -2 split-window -h
    tmux -2 split-window -v
    tmux -2 -2 attach-session -d 
}

currentKeyLayout () {
    plutil -extract AppleSelectedInputSources xml1 -o - ~/Library/Preferences/com.apple.HIToolbox.plist | xmllint --xpath "string(//string[2])" -
}
