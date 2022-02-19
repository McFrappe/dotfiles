# source $HOME/.aliases

# load seperated config files
for conf in "$HOME/.config/zsh/"*.zsh; do
    source ${conf}

    if [ $? -ne 0 ]; then 
        echo "! Failed to source ${conf}.\nReturn code was $?"
        break
    fi

    echo "> Sourced ${conf} successfully."
done
unset conf

# Prompt
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# PROMPT='%B%F{51}%n%f%b:~$ '
# PROMPT="%F{212}%n%f@%F{157}%m%f%B[%b%F{240}%2~%f%B]%b %B$%b "
PROMPT='%F{240}%n%F{red}@%F{141}%m[%F{240}%2~%F{reset}]: '

COLORTERM="truecolor"

# TMUX function
runworkspaces () {
    tmux -2 kill-server
    tmux -2 new-session -s "mySession" -d
    tmux -2 split-window -h
    tmux -2 split-window -v
    tmux -2 -2 attach-session -d 
}
