source $HOME/.aliases

export VISUAL=nvim;
export EDITOR=nvim;
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LANG=en_US.UTF-8

open_by_browser(){ open -a $1 $2}
alias firefox='open_by_browser firefox'

# zmodload zsh/zle
zmodload zsh/complist

autoload -Uz compinit
# autoload edit-command-line
autoload -U colors && colors

# Prompt
autoload -U promptinit; promptinit
prompt restore

export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:/Users/fadde/.config/coc/extensions/extensions/coc-clangd-data/install/12.0.1/clangd_12.0.1/bin
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

fpath=(path/to/zsh-completions/src $fpath)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Has to be the last sourced package
source /Users/fadde/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/usr/local/opt/ncurses/bin:$PATH"

#RUBY
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# sbin dir
export PATH=$PATH:/usr/local/sbin

# libxml2 dir
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libxml2/pkgconfig"

# expat dir
export PATH="/opt/homebrew/opt/expat/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/expat/lib"
export CPPFLAGS="-I/opt/homebrew/opt/expat/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/expat/lib/pkgconfig"

# luarocks
export LUA_PATH='/opt/homebrew/Cellar/luarocks/3.8.0/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?/init.lua;/opt/homebrew/lib/lua/5.4/?.lua;/opt/homebrew/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/fadde/.luarocks/share/lua/5.4/?.lua;/Users/fadde/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/loadall.so;./?.so;/Users/fadde/.luarocks/lib/lua/5.4/?.so'
export PATH='/Users/fadde/.luarocks/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python@3.8/bin:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/expat/bin:/opt/homebrew/opt/libxml2/bin:/opt/homebrew/opt/ruby/bin:/usr/local/opt/ncurses/bin:/usr/local/opt/make/libexec/gnubin:/opt/homebrew/bin:/opt/homebrew/opt/curl/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/texlive:/Library/TeX/texbin:/usr/local/MacGPG2/bin:/usr/local/share/dotnet:~/.dotnet/tools:/Library/Apple/usr/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/fadde/.config/coc/extensions/extensions/coc-clangd-data/install/12.0.1/clangd_12.0.1/bin:/usr/local/sbin'

# Prompt
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# PROMPT='%B%F{51}%n%f%b:~$ '
# PROMPT="%F{212}%n%f@%F{157}%m%f%B[%b%F{240}%2~%f%B]%b %B$%b "
PROMPT='%F{240}%n%F{red}@%F{141}%m[%F{240}%2~%F{reset}]: '

export BAT_THEME="base16"
COLORTERM="truecolor"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"
export OPENBLAS=/opt/homebrew/opt/openblas/lib/
export PATH="/opt/homebrew/sbin:$PATH"

export TERM="xterm-256color"

# TMUX function
runworkspaces () {
    tmux -2 kill-server
    tmux -2 new-session -s "mySession" -d
    tmux -2 split-window -h
    tmux -2 split-window -v
    tmux -2 -2 attach-session -d 
}

