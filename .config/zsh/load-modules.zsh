# zmodload zsh/zle
zmodload zsh/complist

autoload -Uz compinit
# autoload edit-command-line
autoload -U colors && colors

# Prompt
autoload -U promptinit; promptinit
prompt restore

fpath=(path/to/zsh-completions/src $fpath)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Has to be the last sourced package
source /Users/fadde/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

