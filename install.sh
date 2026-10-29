#!/usr/bin/env bash
set -euo pipefail

# Thin wrapper around `mise bootstrap`. All the setup lives declaratively in
# mise/config.toml and mise/config.macos.toml -- see README.md.
#
# The only thing this adds is the config-dir link: ~/.config/mise -> <repo>/mise.
# That makes every file in mise/ global config, so bootstrap loads the
# OS-specific config from any directory. It is the same link that
# `mise bootstrap --from <url> --config-dir mise` creates on a fresh machine;
# this covers a checkout that was cloned by hand.
#
# Any arguments are passed through, e.g:
#   ./install.sh --dry-run
#   ./install.sh --only dotfiles

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config_dir="${MISE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/mise}"

if [[ "$(readlink "$config_dir" 2>/dev/null)" != "$repo/mise" ]]; then
  if [[ -d "$config_dir" && ! -L "$config_dir" ]]; then
    # Migrate the old layout: two file links into this repo, plus the
    # untracked config.local.toml, which moves into mise/ (gitignored).
    for f in config.toml miserc.toml; do
      if [[ -L "$config_dir/$f" && "$(readlink "$config_dir/$f")" == "$repo/"* ]]; then
        rm "$config_dir/$f"
      fi
    done
    if [[ -f "$config_dir/config.local.toml" ]]; then
      if [[ -e "$repo/mise/config.local.toml" ]]; then
        echo "both $config_dir/config.local.toml and $repo/mise/config.local.toml exist; merge them by hand" >&2
        exit 1
      fi
      mv "$config_dir/config.local.toml" "$repo/mise/config.local.toml"
    fi
    if ! rmdir "$config_dir" 2>/dev/null; then
      echo "$config_dir still holds files; move them into $repo/mise or delete them, then re-run" >&2
      ls -A "$config_dir" >&2
      exit 1
    fi
  elif [[ -e "$config_dir" || -L "$config_dir" ]]; then
    echo "$config_dir exists and is not a link to $repo/mise; move it aside, then re-run" >&2
    exit 1
  fi
  mkdir -p "$(dirname "$config_dir")"
  ln -s "$repo/mise" "$config_dir"
  echo "linked $config_dir -> $repo/mise"
fi

exec mise bootstrap "$@"
