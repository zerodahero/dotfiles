#
# ANTIDOTE (plugins)
#

export ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.zsh/}

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=$HOME/.zplugins

# Ensure the .zplugins file exists so you can add plugins.
[[ -f ${zsh_plugins} ]] || touch ${zsh_plugins}

# Lazy-load antidote from its functions directory.
# This is loaded before homebrew env, so if brew install differs, this
# needs to be updated.
fpath=(/opt/homebrew/opt/antidote/share/antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zplugins is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins} ]]; then
  antidote bundle <${zsh_plugins} >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh
