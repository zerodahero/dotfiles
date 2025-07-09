
ZFUNCDIR="$HOME/.zsh/functions"

ZLE_REMOVE_SUFFIX_CHARS=""

## Source the home-path .env file
[ -f $HOME/.env ] && {set -a; source $HOME/.env; set +a}

export EDITOR='nvim'
export MANPAGER='nvim +Man!'

## Projects
export PROJECTS=$HOME/projects

# atuin (history search widget)
export ATUIN_NOBIND="true"

export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

export TERM=xterm-256color
export PATH=$PATH:$(go env GOPATH)/bin:$(go env GOROOT)/bin:$HOME/.composer/vendor/bin:$HOME/bin:$HOME/.local/bin:$HOME/.nimble/bin:$HOME/.dotnet/tools:$HOME/.luarocks/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export ABBR_USER_ABBREVIATIONS_FILE="$HOME/dotfiles/zsh/zsh-abbr/user-abbreviations"
