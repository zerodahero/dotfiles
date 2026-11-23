## Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

## Zstyles
# Load .zstyles file with customizations.
[[ -r $HOME/.zstyles ]] && source $HOME/.zstyles

## Prompt engine
# Resolve before antidote loads, so `conditional:is_p10k` in .zplugins works.
[[ -n $PROMPT_ENGINE ]] || zstyle -s ':prompt' engine PROMPT_ENGINE || PROMPT_ENGINE=p10k
is_p10k() { [[ $PROMPT_ENGINE == p10k ]] }

## Libs
for zlib in $HOME/.zsh/lib/*.zsh; source $zlib
unset zlib

## Aliases
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases
[[ -r ${ZDOTDIR:-$HOME}/.zaliases.local ]] && source ${ZDOTDIR:-$HOME}/.zaliases.local

# Lazy loads
source "$HOME/.zsh/lazy-loads/kubectl.zsh"

## Prompt
if is_p10k; then
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  # The theme lives next to the real .zshrc (this file is a symlink).
  eval "$(oh-my-posh init zsh --config ${${(%):-%x}:A:h}/oh-my-posh.yaml)"
fi

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

true
