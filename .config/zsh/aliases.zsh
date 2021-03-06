# Towared root navigations
alias ..1dir="cd .."
alias ..2dir="cd ../.."
alias ..3dir="cd ../../.."
alias ..4dir="cd ../../../.."

# Trim new lines and copy to clippboard
alias c="tr -d '\n' | pbcopy" 

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# copy current directory
alias ccd="pwd | c"  

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

alias vim="nvim" 
alias weather="curl wttr.in"
alias sleep="pmset sleepnow"

# source_files=("$HOME/.zshrc" "$HOME/.aliases")
# function source_shell_files() {
#     for file in ${source_files[@]}; do
#         source $file;
#         echo "Sourced file: $file"
#     done
# }
