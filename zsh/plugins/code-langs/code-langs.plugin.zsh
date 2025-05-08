[ -e "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
alias stack='C_INCLUDE_PATH="`xcrun --show-sdk-path`/usr/include/ffi" stack'

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# _evalcache pyenv init - zsh
cached-eval "$(pyenv init - zsh)"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
# [[ -f /Users/zero/.dart-cli-completion/zsh-config.zsh ]] && . /Users/zero/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

. "$HOME/.cargo/env"

export CLOUDSDK_PYTHON_SITEPACKAGES=1

export PATH="$HOME/.juliaup/bin:$PATH"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/zack.teska/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/zack.teska/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.6%252B7/OpenJDK21U-jdk_aarch64_mac_hotspot_21.0.6_7.tar.gz/jdk-21.0.6+7/Contents/Home"
# <<< JVM installed by coursier <<<

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#
