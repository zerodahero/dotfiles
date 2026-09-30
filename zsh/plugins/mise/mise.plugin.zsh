# mise completions
() {
  local comp=${1:a:h}/_mise
  (( $+commands[mise] )) || return
  [[ -s $comp && $comp -nt $commands[mise] ]] && return
  mise completion zsh >| $comp
} ${(%):-%N}

cached-eval 'mise' mise activate zsh
cached-eval 'fnox' fnox activate zsh
