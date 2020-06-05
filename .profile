# Set default directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Set application locations
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave/history"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# Add cargo to $PATH
export PATH="$HOME/.local/share/cargo/bin:$PATH"

# Start desktop environment if one not already started
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
