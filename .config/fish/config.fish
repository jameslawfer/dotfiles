alias ls='lsd'

# Alias for tracking dotfiles with git easily (see https://news.ycombinator.com/item?id=11070797)
alias gitdot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias for cding into symlink directories, to go to the real folder
alias cds='cd -P'

# alias for finding a string in the current directory including subdirectories
alias fsic='find . -name'

# some more ls aliases
alias ll='ls -l'
alias lt='ls -lhA'
alias lr='ls -lhAt | head'

alias getwanip='wget -qO- http://ipecho.net/plain ; echo'

alias fif='grep -iRl'

# copy with rsync/progress alias
alias rp='rsync -ha --progress'

# Alias for reminding not to use rm and use trash-cli instead
alias rm='echo "Nope use trash instead! (If you really need rm just prepend as follows: command rm <file>)"; false'

# Alias for connecting to a WiFi network on wlan0 interface
alias iwcon='iwctl station wlan0 scan && iwctl station wlan0 connect'

# Alias for checking upower status
alias charge='upower --dump'

# Alias for excluding network storage from ncdu
alias ncdu='ncdu --exclude /home/james/CATNAS'

# Alias for starting keep-presence
#alias kp='cd ~/Source/keep-presence/ && poetry run python3 src/keep-presence.py -s 5 -m both -p 5'
alias kp='keep-presence.py -s 5 -m both -p 5'

# Aliases for starting barrier
alias barr-01='barrierc --restart --daemon 10.8.99.157' # for home with work laptop as server
alias barr-02='barrierc --restart --daemon 192.168.1.33' # for GulliesHome with work laptop as server

# Alias to not combine AUR and pacman upgrades with Yay
alias yay='yay --combinedupgrade=false'
