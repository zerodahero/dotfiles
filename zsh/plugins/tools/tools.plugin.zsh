[ -e ~/.fzf.zsh ] && source ~/.fzf.zsh

(type clockify-cli &> /dev/null) && source <(clockify-cli completion zsh)

# IntelliShell
export INTELLI_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/intelli-shell"
export INTELLI_SKIP_ESC_BIND=1          # keep ESC for vi-mode
export INTELLI_BOOKMARK_HOTKEY='^b'
export INTELLI_SEARCH_HOTKEY='^X^S'
export INTELLI_FIX_HOTKEY='^X^F'        # off bare ^x
export INTELLI_VARIABLE_HOTKEY='^X^V'   # off ^l
cached-eval 'intelli-shell' intelli-shell init zsh

cached-eval 'thefuck' thefuck --alias
