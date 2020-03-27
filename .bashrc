# ~/.bashrc

# tmux starting
if [[ $DISPLAY ]]; then
	 if [ -t 0 ] && [[ -z "$TMUX" ]] ;then
		  ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
		  if [[ -z "$ID" ]] ;then # if not available create a new one
				exec tmux new-session
		  else
				exec tmux attach-session -t "$ID" # if available attach to it
		  fi
	 fi
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -laF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias mpvt='mpv --ontop --geometry=25%+100%+0' # launches mpv window that will always be on top
alias unzip='7z x' # but folder name after it
alias open='xdg-open'
alias pynvim='source $HOME/.virtualenvs/neovim3/bin/activate'
alias latex='xelatex -output-directory=compiled'

# history
HISTFILE="$XDG_DATA_HOME/bash/history"
export HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=102400
HISTSIZE=102400

# virtual environement
function virtualenv_info() {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    fi
    [[ -n "$venv" ]] && echo "(venv:$venv) "
}
# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

# git
[ -f /usr/share/git/completion/git-completion.bash ] && source /usr/share/git/completion/git-completion.bash
[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto
PROMPT_COMMAND='VENV="\$(virtualenv_info)"; \
    __git_ps1 "${VENV}\[\e[38;2;115;218;250m\][\w\[\e[0;37m\]" "\[\e[38;2;115;218;250m\]]$ \[\e[m\]"'

# ssh agent
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent > ~/.ssh-agent-thing
#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#    eval "$(<~/.ssh-agent-thing)"
#fi

# dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# bspwm export variable
export XDG_CONFIG_HOME="$HOME/.config"

# fzf
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f $HOME/.config/fzf/fzf.bash ] && source $HOME/.config/fzf/fzf.bash
