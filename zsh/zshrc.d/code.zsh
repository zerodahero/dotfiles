# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
[ -e "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
alias stack='C_INCLUDE_PATH="`xcrun --show-sdk-path`/usr/include/ffi" stack'

. "$HOME/.cargo/env"

export CLOUDSDK_PYTHON_SITEPACKAGES=1

export PATH="$HOME/.juliaup/bin:$PATH"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/zack.teska/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/zack.teska/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.6%252B7/OpenJDK21U-jdk_aarch64_mac_hotspot_21.0.6_7.tar.gz/jdk-21.0.6+7/Contents/Home"
# <<< JVM installed by coursier <<<
