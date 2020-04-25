# autoload external functions
autoload -Uz compinit && compinit -u -d $HOME/.cache/zsh/zcompdump-$ZSH_VERSION

# change directory quicker
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ls options quicker
alias ls='ls -G'
alias ll='ls -l'
alias l='ls -lAv'

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
[ -x "$(command -v nvim)" ] && alias vi='nvim' # nvim
[ -x "$(command -v rg)" ] && alias grep='rg' # ripgrep

# determine python enironment
function virtualenv_info () {
    if [ -n "$VIRTUAL_ENV" ]; then
        venv="${VIRTUAL_ENV##*/}"
    fi
    [ -n "$venv" ] && echo "(venv:$venv)"
}

# git
[ -f $HOME/.local/share/git/completion/git-prompt.sh ] && source $HOME/.local/share/git/completion/git-prompt.sh && \
    GIT_PS1_SHOWCOLORHINTS=1 && \
    GIT_PS1_SHOWUNTRACKEDFILES=1 && \
    GIT_PS1_SHOWUPSTREAM=auto

# colours
puple="#e7c1f4"
# zsh prompt
START="%F{${puple}}%~%f"
END="%F{${puple}}%f%s :: "
if [ "$(command -v __git_ps1)" ]; then
    precmd () { __git_ps1 "$(virtualenv_info) "${START} ${END} }
else
    PROMPT="$(virtualenv_info) "${START}${END}
fi


# fzf
[ -f $(brew --prefix)/opt/fzf/shell/key-bindings.zsh ] && source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
[ -f $(brew --prefix)/opt/fzf/shell/completion.zsh ] && source $(brew --prefix)/opt/fzf/shell/completion.zsh
[ -f $HOME/.config/fzf/fzf.zsh ] && source $HOME/.config/fzf/fzf.zsh

# zsh syntax completion
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && \
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=#b0e5b5' && ZSH_HIGHLIGHT_STYLES[path]=''

# syntax highlighting (brew)
[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && \
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=#b0e5b5' && ZSH_HIGHLIGHT_STYLES[path]=''

# dotfiles
[ -d $HOME/.config/dotfiles ] && alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
