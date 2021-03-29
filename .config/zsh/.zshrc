# autoload external functions
autoload -Uz compinit && compinit -d $HOME/.cache/zsh/zcompdump-$ZSH_VERSION

# change directory quicker
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ls options quicker
alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -lAv'

# ip route colour output
alias ip='ip -color=auto'

# case insensitive completion if there is no matching case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# move through menu when multiple choices
zstyle ':completion:*' menu select

# history
HISTFILE="$HOME/.local/share/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE

# use programs if installed
[ -x "$(command -v nvim)" ] && alias vi='nvim' # nvim
# gdb intel assembly display
[ -f $HOME/.config/gdb/init ] && [ -x "$(command -v gdb)" ] && \
	alias gdb='gdb -nh -x $XDG_CONFIG_HOME/gdb/init' # gdb
# tmux alias
[ -f $HOME/.config/tmux/tmux.conf ] && alias tmux='tmux -u -f $HOME/.config/tmux/tmux.conf'
# dotfiles
[ -d $HOME/.config/dotfiles ] && alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'

# determine python enironment
function virtualenv_info () {
	if [ -n "$VIRTUAL_ENV" ]; then
		venv="${VIRTUAL_ENV##*/}"
	fi
	[ -n "$venv" ] && echo "(venv:$venv) "
}

# git
[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh && \
	GIT_PS1_SHOWCOLORHINTS=1 && \
	GIT_PS1_SHOWUNTRACKEDFILES=1 && \
	GIT_PS1_SHOWUPSTREAM=auto

# colours
puple="#f1bef7"
dim_red="#f7adae"
# zsh prompt
START="%F{${dim_red}}$PCNAME%f : %F{${puple}}%~%f"
END="%F{${puple}}%f%s :: "
if [ "$(command -v __git_ps1)" ]; then
	precmd () { __git_ps1 "%F{158}$(virtualenv_info)%f"${START} ${END} }
else
	PROMPT="$(virtualenv_info)"${START}${END}
fi

# fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -x "$(command -v fzf)" ] && [ -f $HOME/.config/zsh/fzf.zsh ] && source $HOME/.config/zsh/fzf.zsh

# zsh syntax completion
light_green="#b0e5b5"
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && \
	ZSH_HIGHLIGHT_STYLES[arg0]='fg='${light_green} && ZSH_HIGHLIGHT_STYLES[path]=''

