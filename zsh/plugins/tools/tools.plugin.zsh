[ -e ~/.fzf.zsh ] && source ~/.fzf.zsh

(type clockify-cli &> /dev/null) && source <(clockify-cli completion zsh)
(type kbcli &> /dev/null) && source <(kbcli completion zsh)
(type restic &> /dev/null) && source $HOME/.restic/resticrc

cached-eval "$(thefuck --alias)"
# _evalcache direnv hook zsh

