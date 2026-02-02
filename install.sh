#!/usr/bin/env bash
set -euo pipefail

## Prompt for overwrite behavior
echo "How should existing files be handled?"
echo "  1) Overwrite all (no prompts)"
echo "  2) Prompt for each file (default)"
echo "  3) Skip existing files"
read -rp "Choice [1/2/3]: " choice

case "$choice" in
1)
    install_mode="overwrite"
    ;;
3)
    install_mode="skip"
    ;;
*)
    install_mode="interactive"
    ;;
esac

link() {
    mkdir -p "$(dirname "$2")"
    case "$install_mode" in
    overwrite)
        ln -sfn "$1" "$2"
        ;;
    skip)
        ln -sn "$1" "$2" 2>/dev/null || true
        ;;
    interactive)
        ln -sin "$1" "$2"
        ;;
    esac
}

## Nvim
link "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

## Global Formatters
link "$HOME/dotfiles/formatters/editorconfig" "$HOME/.editorconfig"
link "$HOME/dotfiles/formatters/lua-format" "$HOME/.lua-format"
link "$HOME/dotfiles/formatters/stylua.toml" "$HOME/.stylua.toml"
link "$HOME/dotfiles/formatters/sqruff" "$HOME/.sqruff"
link "$HOME/dotfiles/formatters/markdownlint.jsonc" "$HOME/.markdownlint.jsonc"
link "$HOME/dotfiles/formatters/yamllint" "$HOME/.config/yamllint/config"
link "$HOME/dotfiles/formatters/yamlfmt" "$HOME/.config/yamlfmt/.yamlfmt"
link "$HOME/dotfiles/formatters/cspell.json" "$HOME/.cspell.json"
mkdir -p "$HOME/.config/cspell" && touch "$HOME/.config/cspell/user-dictionary.txt"
link "$HOME/dotfiles/formatters/pg_format" "$HOME/.pg_format"

## ZSH
link "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
link "$HOME/dotfiles/zsh/.zaliases" "$HOME/.zaliases"
link "$HOME/dotfiles/zsh/.zstyles" "$HOME/.zstyles"
link "$HOME/dotfiles/zsh/lazy-loads/kubectl.zsh" "$HOME/.zsh/lazy-loads/kubectl.zsh"
link "$HOME/dotfiles/zsh/.zplugins" "$HOME/.zplugins"
link "$HOME/dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link "$HOME/dotfiles/zsh/functions/" "$HOME/.zsh/functions"
link "$HOME/dotfiles/zsh/lib/" "$HOME/.zsh/lib"
link "$HOME/dotfiles/zsh/plugins/" "$HOME/.zsh/plugins"
link "$HOME/dotfiles/zsh/zshrc.d/" "$HOME/.zshrc.d"

## Mise
link "$HOME/dotfiles/mise/config.toml" "$HOME/.config/mise.toml"

### OS Specific  files
case "$(uname -s)" in
Darwin)
    link "$HOME/dotfiles/yabai/yabairc" "$HOME/.config/yabai/yabairc"
    link "$HOME/dotfiles/yabai/intellij_yabai.sh" "$HOME/.config/yabai/intellij_yabai.sh"
    link "$HOME/dotfiles/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"
    link "$HOME/dotfiles/window.justfile" "$HOME/.window.justfile"
    link "$HOME/dotfiles/k8s.justfile" "$HOME/.k8s.justfile"
    [ -f "$HOME/.user.justfile" ] || cp -n "$HOME/dotfiles/user.justfile.tmpl" "$HOME/.user.justfile"
    link "$HOME/dotfiles/mac/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
    ;;
Linux) ;;
esac

## Global justfiles

## Kitty
link "$HOME/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
link "$HOME/dotfiles/kitty/current-theme.conf" "$HOME/.config/kitty/current-theme.conf"
link "$HOME/dotfiles/kitty/project_tab_title.py" "$HOME/.config/kitty/project_tab_title.py"

## Projects directory setup
mkdir -p "$HOME/projects"
[ -f "$HOME/.projects" ] || echo "$HOME/dotfiles" > "$HOME/.projects"
