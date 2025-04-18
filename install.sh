#!/bin/bash

## Nvim
mkdir -p "$HOME/.config"
ln -si "$HOME/dotfiles/nvim" "$HOME/.config"

## Global Formatters
ln -si "$HOME/dotfiles/formatters/editorconfig" "$HOME/.editorconfig"
ln -si "$HOME/dotfiles/formatters/lua-format" "$HOME/.lua-format"
ln -si "$HOME/dotfiles/formatters/markdownlint.jsonc" "$HOME/.markdownlint.jsonc"
mkdir -p "$HOME/.config/yamllint"
ln -si "$HOME/dotfiles/formatters/yamllint" "$HOME/.config/yamllint/config"
mkdir -p "$HOME/.config/yamlfmt"
ln -si "$HOME/dotfiles/formatters/yamlfmt" "$HOME/.config/yamlfmt/.yamlfmt"

## ZSH
ln -si "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.zsh/lazy-loads"
ln -si "$HOME/dotfiles/zsh/lazy-loads/kubectl.zsh" "$HOME/.zsh/lazy-loads/kubectl.zsh"

### Agnoster, real theme from repo
git clone https://github.com/agnoster/agnoster-zsh-theme.git "$HOME/.oh-my-zsh/custom/themes/agnoster"
ln -si "$HOME/.oh-my-zsh/custom/themes/agnoster/agnoster.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/agnoster.zsh-theme"

### OS Specific  files
case "$(uname -s)" in
    Darwin)
        ln -si "$HOME/dotfiles/.zshrc-darwin" "$HOME/.zshrc-darwin"
        mkdir -p "$HOME/.config/yabai" "$HOME/.config/skhd"
        ln -si "$HOME/dotfiles/yabai/yabairc" "$HOME/.config/yabai/yabairc"
        ln -si "$HOME/dotfiles/yabai/intellij_yabai.sh" "$HOME/.config/yabai/intellij_yabai.sh"
        ln -si "$HOME/dotfiles/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"
        ln -si "$HOME/dotfiles/window.justfile" "$HOME/.window.justfile"
        [ -f "$HOME/.user.justfile" ] || cp -n "$HOME/dotfiles/user.justfile.tmpl" "$HOME/.user.justfile"
        mkdir -p "$HOME/Library/KeyBindings"
        ln -si "$HOME/dotfiles/mac/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/"
    ;;
    Linux)
    ;;
esac

## Global justfiles
# ln -si "$HOME/dotfiles/ollama.justfile" "$HOME/.ollama.justfile"

### Kitty
ln -si "$HOME/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -si "$HOME/dotfiles/kitty/current-theme.conf" "$HOME/.config/kitty/current-theme.conf"

## Projects directory setup
mkdir -p "$HOME/projects"
[ -f "$HOME/.projects" ] || echo "$HOME/dotfiles" > "$HOME/.projects"
