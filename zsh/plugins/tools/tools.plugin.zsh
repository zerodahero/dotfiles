[ -e ~/.fzf.zsh ] && source ~/.fzf.zsh

(type clockify-cli &> /dev/null) && source <(clockify-cli completion zsh)
(type restic &> /dev/null) && source $HOME/.restic/resticrc

cached-eval 'thefuck' thefuck --alias

