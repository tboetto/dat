#!/bin/zsh

# export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
eval "$(pyenv init --path)"

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave"


# ~/ Clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export STARTX="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export TOOLS="$HOME/.tools"
# export PATH="$PYENV_ROOT/bin:$PATH"
