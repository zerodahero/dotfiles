#!/bin/bash

## Vim
ln -si "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"

## ZSH
ln -si "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -si "$HOME/dotfiles/.oh-my-zsh/custom/themes/agnoster.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/agnoster.zsh-theme"
mkdir -p "$HOME/.zsh/lazy-loads"
ln -si "$HOME/dotfiles/zsh/lazy-loads/kubectl.zsh" "$HOME/.zsh/lazy-loads/kubectl.zsh"

## tmux
ln -si "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
[ ! -d "$HOME/.tmux/plugins/tpm" ] \
    && git clone https://github.com/tmux-plugins/tpm \
    "$/.tmux/plugins/tpm"

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

### Kitty
ln -si "$HOME/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -si "$HOME/dotfiles/kitty/current-theme.conf" "$HOME/.config/kitty/current-theme.conf"
