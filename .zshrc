# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
eval "$(brew shellenv)"
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Lazy loads
source "$HOME/.zsh/lazy-loads/kubectl.zsh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(zsh-nvm git kube-ps1 evalcache git-trim brew zsh-syntax-highlighting)

ZLE_REMOVE_SUFFIX_CHARS=""

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# DEFAULT_USER=$(whoami)
DEFAULT_USER=$USER

# ssh-add -K ~/.ssh/id_rsa

# autoload -U +X compinit && compinit
# autoload -U +X bashcompinit && bashcompinit

setopt nosharehistory

# (which kubectl > /dev/null) && source <(kubectl completion zsh)
(type clockify-cli &> /dev/null) && source <(clockify-cli completion zsh)
(type kbcli &> /dev/null) && source <(kbcli completion zsh)

(type restic &> /dev/null) && source $HOME/.restic/resticrc

_evalcache thefuck --alias
_evalcache direnv hook zsh

# export GOPATH=$HOME/projects/golang
export PATH=$PATH:$(go env GOPATH)/bin:$(go env GOROOT)/bin:$HOME/.composer/vendor/bin:$HOME/bin:$HOME/.local/bin:$HOME/.nimble/bin:$HOME/.dotnet/tools:$HOME/.luarocks/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias dco="docker compose"
# alias phpfix="php-cs-fixer fix"
alias art="php artisan"
function v () {
    [[ $# -lt 1 ]] && return 1
    if [[ -d vendor/bin ]]; then
        ./vendor/bin/$@
    else
        echo "Not at composer project root"
    fi
}

function git-fresh () {
	git checkout $1 \
	&& git fetch origin \
	&& git pull --prune
}

function git-find-deleted () {
    git log --diff-filter=D --summary |grep delete | grep -i $1
}

function git-undelete () {
    git checkout $(git rev-list -n 1 HEAD -- "$1")^ -- "$1"
}

function sub.env () {
    local envpath=${3:-".env"}
    if [ ! -f ${envpath} ]
    then
        echo "No .env found at ${envpath}"
        return 1
    fi
    if [ $# -lt 2 ]
    then
        echo "Expecting format: sub.env ENV_VAR value (optional: .env)"
        return 1
    fi
    (cat ${envpath} | grep -q $1) || echo "\n$1=" >> ${envpath}
    sed -i '' -e 's/\('$1'=\).*/\1'$2'/' "${envpath}"
}

function clockify-cli-append () {
    local desc=$(clockify-cli show current -f "{{ .Description }}")
    if [ -z "$desc" ]
    then
        echo "No time being currently tracked"
        return;
    fi
    clockify-cli edit current --description="${desc}
$1"
}

function jcat () {
    jq --color-output . $1 | less -R
}

# export TODOTXT_DEFAULT_ACTION=ls
# alias t=todo.sh
# alias todo=todo.sh
# alias ta="todo.sh add"
alias .t="taskell $HOME/taskell.md"

setopt APPEND_HISTORY

export TERM=xterm-256color

# Ruby and Ruby Gems
# export PATH="/usr/local/opt/ruby/bin:$PATH"
# if which ruby >/dev/null && which gem >/dev/null; then
#   PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
# fi

# OS specific stuff
case "$OSTYPE" in
    darwin*)
        source "${ZDOTDIR:-${HOME}}/.zshrc-darwin"
    ;;
    linux*)
        # arch specific
    ;;
esac

[ -e "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
alias stack='C_INCLUDE_PATH="`xcrun --show-sdk-path`/usr/include/ffi" stack'

function kubeon-ns () {
    export KUBE_PS1_NS_ENABLE=true
}
function kubeoff-ns () {
    export KUBE_PS1_NS_ENABLE=false
}

KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_PREFIX=''
KUBE_PS1_SUFFIX=''
KUBE_PS1_SYMBOL_PADDING=false
KUBE_PS1_NS_ENABLE=false
KUBE_PS1_CTX_COLOR=black
KUBE_PS1_NS_COLOR=blue

# K8s context off by default
kubeoff

# AWS profiles
function awsctx () {
    if [ -z $1 ]; then
        sed -n -E 's/^\[(.+)\]$/\1/p' ~/.aws/credentials
        return;
    fi
    export AWS_PROFILE=$1
    aws configure list
}

alias .j='just --justfile ~/.user.justfile --working-directory .'
alias .n='just --justfile ~/.dotnet.justfile --working-directory .'
alias .c='just --justfile ~/.clockify.justfile --working-directory .'

alias go="grc go"

# alias sail="[ -f sail ] && bash sail || bash vendor/bin/sail"

# atuin (history search widget)
export ATUIN_NOBIND="true"
_evalcache atuin init zsh
bindkey '^r' _atuin_search_widget

# eval "$(op completion zsh)"; compdef _op op
_evalcache op completion zsh; compdef _op op
export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"

alias vim=nvim
alias vimdiff='nvim -d'

[ -e ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/bit bit

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Projen
alias pj='npx projen'

vsso() {
   local profile=$1
   if [ $# -eq 0 ]; then
      profile=$(aws configure list-profiles | fzf)
   fi
   aws-sso-util login --profile $profile && awsume $profile
   export AWS_PROFILE=$profile
}

zshstartuptime() {
   for i in $(seq 0 10); do time /bin/zsh -i -c exit; done
}
