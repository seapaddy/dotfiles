# autoload external functions
autoload -Uz compinit && compinit

# change directory quicker
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ls options quicker
alias ls='ls -G'
alias ll='ls -l'
alias l='ls -laF'

# function alias
alias audio='youtube-dl -f bestaudio' # audio download from youtube

# case insensitive completion if there is no matching case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# move through menu when multiple choices
zstyle ':completion:*' menu select

# history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE

# tmux
if [ -t 0 ] && [[ -z "$TMUX" ]] && [[ $- = *i* ]] ;then
	 ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
	 if [[ -z "$ID" ]] ;then # if not available create a new one
		  exec tmux new-session
	 else
		  exec tmux attach-session -t "$ID" # if available attach to it
	 fi
fi

# determine python enironment
function virtualenv_info () {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo "(venv:$venv) "
}

# git
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=0
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto
[ -f $HOME/.git-prompt.sh ] && source $HOME/.git-prompt.sh

# zsh prompt
precmd () { __git_ps1 "$(virtualenv_info)%F{#99bbff}[%~%f" "%F{#99bbff}]%f%s " }

# fzf
[ -f $HOME/.config/fzf/fzf.zsh ] && source $HOME/.config/fzf/fzf.zsh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# syntax highlighting (brew)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# path environment variable
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
