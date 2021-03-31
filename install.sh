#!/bin/bash

## Vim
ln -si "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"

## ZSH
ln -si "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -si "$HOME/dotfiles/.oh-my-zsh/custom/themes/agnoster.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/agnoster.zsh-theme"

### OS Specific  files
case "$(uname -s)" in
    Darwin)
        ln -si "$HOME/dotfiles/.zshrc-darwin" "$HOME/.zshrc-darwin"
        mkdir -p "$HOME/.config/yabai" "$HOME/.config/skhd"
        ln -si "$HOME/dotfiles/yabai/yabairc" "$HOME/.config/yabai/yabairc"
        ln -si "$HOME/dotfiles/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"
    ;;
    Linux)
    ;;
esac
