alias ls='lsd'
alias lt='ls -la'

# Alias for tracking dotfiles with git easily (see https://news.ycombinator.com/item?id=11070797)
alias gitdot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias for cding into symlink directories, to go to the real folder
alias cds='cd -P'

# alias for finding a string in the current directory including subdirectories
alias fsic='find . -name'

# some more ls aliases
alias ll='ls -l'
alias lt='ls -lhA'

alias getwanip='wget -qO- http://ipecho.net/plain ; echo'

alias fif='grep -iRl'
