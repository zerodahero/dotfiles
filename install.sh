#!/usr/bin/env bash
set -euo pipefail

# Thin wrapper around `mise bootstrap`. All the setup now lives declaratively in
# mise/config.toml and mise/config.macos.toml -- see README.md.
#
# The only thing this adds is the cd. mise/config.<os>.toml is a project-scoped
# config path, so running `mise bootstrap` from anywhere else silently skips the
# OS-specific dotfiles and hooks. Running it from here guarantees the full set.
#
# Any arguments are passed through, e.g:
#   ./install.sh --dry-run
#   ./install.sh --only dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")"

exec mise bootstrap "$@"
