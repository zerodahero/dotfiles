bindkey '^r' _atuin_search_widget

zvm_bindkey vicmd '^r' _atuin_search_widget

autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word

bindkey -M viins '\e.' insert-last-word
