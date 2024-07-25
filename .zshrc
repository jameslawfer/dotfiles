# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v4/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
zstyle ':z4h:'                auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:'                auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey'         keyboard         'pc'
# When fzf menu opens on TAB, another TAB moves the cursor down ('tab:down')
# or accepts the selection and triggers another TAB-completion ('tab:repeat')?
zstyle ':z4h:fzf-complete'    fzf-bindings     'tab:down'
# When fzf menu opens on Alt+Down, TAB moves the cursor down ('tab:down')
# or accepts the selection and triggers another Alt+Down ('tab:repeat')?
zstyle ':z4h:cd-down'         fzf-bindings     'tab:down'
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char     'accept'

# Send these files over to the remote host when connecting over ssh.
# Multiple files can be listed here.
zstyle ':z4h:ssh:*'           send-extra-files '~/.iterm2_shell_integration.zsh'
# Disable automatic teleportation of z4h over ssh when connecting to some-host.
# This makes `ssh some-host` equivalent to `command ssh some-host`.
#zstyle ':z4h:ssh:some-host'   passthrough      'yes'

# Move the cursor to the end when Up/Down fetches a command from history?
zstyle ':zle:up-line-or-beginning-search'   leave-cursor 'yes'
zstyle ':zle:down-line-or-beginning-search' leave-cursor 'yes'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Export environment variables.
export GPG_TTY=$TTY

# Extend PATH.
path=(~/bin $path)

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/diagnostics.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/emoji-clock/emoji-clock.plugin.zsh
fpath+=($Z4H/ohmyzsh/ohmyzsh/plugins/supervisor)

# Source additional local files if they exist.
z4h source ~/.iterm2_shell_integration.zsh

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/  # undo the last command line change
z4h bindkey redo Alt+/   # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Replace `ssh` with `z4h ssh` to automatically teleport z4h to remote hosts.
#function ssh() { z4h ssh "$@" }

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -n $z4h_win_home ]] && hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
#alias ls="${aliases[ls]:-ls} -A"
alias ls='lsd'
alias ls="${aliases[ls]:-ls} -h"
alias ll='ls -l'
alias la='ls -la'
alias lr='ls -lAt | head'

# Alias for tracking dotfiles with git easily (see https://news.ycombinator.com/item?id=11070797)
alias gitdot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias for cding into symlink directories, to go to the real folder
alias cds='cd -P'

# alias for finding a string in the current directory including subdirectories
alias fsic='find . -name'

alias getwanip='wget -qO- http://ipecho.net/plain ; echo'

alias fif='grep -iRl'

# copy with rsync/progress alias
alias rp='rsync -ha --progress'

# Alias for reminding not to use rm and use trash-cli instead
alias rm='echo "Nope use trash instead! (If you really need rm just prepend as follows: \\\rm <file>)"; false'

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
alias barr-01='barrierc --restart --daemon 10.8.99.21' # for home with work laptop as server

# Alias to not combine AUR and pacman upgrades with Yay
alias yay='yay --combinedupgrade=false'

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
