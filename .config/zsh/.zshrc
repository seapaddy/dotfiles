# autoload external functions
autoload -Uz compinit && compinit -d $HOME/.cache/zsh/zcompdump-$ZSH_VERSION

# change directory quicker
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

export CLICOLOR=1
# ls options quicker
alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -laF'

# case insensitive completion if there is no matching case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# move through menu when multiple choices
zstyle ':completion:*' menu select

# history
# HISTFILE=$HOME/.zsh_history
HISTFILE="$HOME/.local/share/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE

# tmux
if [[ $DISPLAY ]]; then
	 if [ -t 0 ] && [[ -z "$TMUX" ]] ;then
		  ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
		  if [[ -z "$ID" ]] ;then # if not available create a new one
				exec tmux -f $HOME/.config/tmux/tmux.conf
		  else
				exec tmux attach-session -t "$ID" # if available attach to it
		  fi
	 fi
fi

# determine python enironment
function virtualenv_info () {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo "(venv:$venv) "
}

# git
[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto

# zsh prompt
precmd () { __git_ps1 "$(virtualenv_info)%B%F{#99bbff}[%~%f%b" "%B%F{#99bbff}]%f%b%s " }

# fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f $HOME/.config/fzf/fzf.zsh ] && source $HOME/.config/fzf/fzf.zsh

# zsh syntax completion
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh syntax completion personal settings
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#b0e5b5'
ZSH_HIGHLIGHT_STYLES[path]=''

# dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles/.dotfiles/ --work-tree=$HOME'

# gdb
alias gdb='gdb -nh -x $XDG_CONFIG_HOME/gdb/init'
