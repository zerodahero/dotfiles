## Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

## Zstyles
# Load .zstyles file with customizations.
[[ -r $HOME/.zstyles ]] && source $HOME/.zstyles

## Libs
for zlib in $HOME/.zsh/lib/*.zsh; source $zlib
unset zlib

## Aliases
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Lazy loads
source "$HOME/.zsh/lazy-loads/kubectl.zsh"

## Prompt
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

true
