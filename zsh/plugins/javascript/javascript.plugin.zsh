# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# FNM
# _evalcache fnm env --use-on-cd --shell zsh
cached-eval "$(fnm env --use-on-cd --shell zsh)"
