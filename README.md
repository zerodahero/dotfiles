# dotfiles

Machine setup is driven by [mise](https://mise.jdx.dev). One command provisions
a machine:

```sh
./install.sh          # = link ~/.config/mise -> mise/, then mise bootstrap
```

`~/.config/mise` is a symlink to this repo's `mise/` directory. Every file in
it is global config, so `mise bootstrap` works from any directory. One
consequence: `mise use -g` and `mise dot add` write into this repo.

## New machine

```sh
# 1. Xcode command line tools (manual -- Apple gates this)
xcode-select --install

# 2. Homebrew -- OPTIONAL. mise installs brew formulae and casks itself, into
#    the same /opt/homebrew prefix, without brew. Install it only if you want
#    the `brew` CLI for ad-hoc use.
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. mise
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

# 4. Clone to ~/dotfiles, link ~/.config/mise to its mise/, and bootstrap.
#    The path is NOT arbitrary -- see below.
mise bootstrap --from git@github.com:zerodahero/dotfiles.git --from-dir ~/dotfiles --config-dir mise

# 5. Machine identity -- create by hand, see "Machine identity" below,
#    then re-run to render ~/.gitconfig.local
"$EDITOR" ~/dotfiles/mise/config.local.toml
mise bootstrap
```

If you cloned by hand instead, `~/dotfiles/install.sh` creates the same link
and runs bootstrap. It also migrates the old layout (file links inside a real
`~/.config/mise`).

Then open a new shell so activation takes effect.

### The repo must live at `~/dotfiles`

Every `[dotfiles]` source is an absolute `~/dotfiles/...` path, because this
repo is topic-per-directory and its config is reachable by two paths, which
makes relative sources ambiguous. So always pass `--from-dir ~/dotfiles`.

## Machine identity

`~/.gitconfig.local` is rendered from `git/config.local.tmpl` by mise. Do not
edit it — `mise bootstrap` overwrites it. Set the values in
`mise/config.local.toml` (reached as `~/.config/mise/config.local.toml`).
It is gitignored, so it never enters this public repo:

```toml
[vars]
git_name        = "..."
git_email       = "..."
git_signing_key = "ssh-ed25519 AAAA..." # public key, safe to store
```

The template has no default values on purpose. Until this file exists,
`mise dotfiles status` reports a render error for `~/.gitconfig.local` rather
than quietly writing an empty name.

## Layout

| Path | Role |
|---|---|
| `mise/config.toml` | Global mise config **and** the bootstrap definition: `[tools]`, `[dotfiles]`, `[bootstrap.*]` |
| `mise/config.macos.toml` | macOS-only dotfiles and setup steps |
| `mise/miserc.toml` | Sets `MISE_ENV` from `os()`, which selects the file above |
| everything else | Topic directories (`zsh/`, `nvim/`, `git/`, …) linked into place by `[dotfiles]` |

TODO: Add Linux support (add `mise/config.linux.toml`)

## Useful commands

```sh
mise dotfiles status              # per-path: applied / missing / differs
mise dotfiles diff                # what an apply would change
mise bootstrap --dry-run          # the whole plan, executing nothing
mise bootstrap --only dotfiles    # run one phase
mise bootstrap --upgrade          # also upgrade installed packages and tools
mise bootstrap --prune-dotfiles   # also remove dotfiles no entry deploys now
mise trust                        # required after cloning or editing config
```

Hooks run on every `mise bootstrap`, so every hook command must be idempotent.

`mise bootstrap` converges: anything already in its desired state is skipped,
so re-running is safe. It is **not** transactional — if a later phase fails,
earlier changes remain.

If an apply refuses because a real file sits where a symlink belongs, do **not**
reach for `--force-dotfiles`. Use `mise dotfiles add <path>`, which moves the
file to its source path before linking.

## macOS system preferences

`mise/config.macos.toml` declares Dock, Finder, keyboard, etc preferences.

```sh
mise bootstrap macos defaults status   # expect every row "set"
mise bootstrap macos defaults apply
```

Some changes need an app relaunch (`killall Dock`, `killall Finder`).

## Packages

`mise/config.macos.toml` declares Homebrew formulae and casks under
`[bootstrap.packages]`. mise installs them into the canonical `/opt/homebrew`
prefix, doing the same relocation, code-signing and linking work brew does, and
maintaining brew's own `<prefix>/var/homebrew/linked/<name>` records — so
brew-installed and mise-installed formulae coexist in one prefix.

```sh
mise bootstrap packages status                # per-package state
mise bootstrap packages use brew:ripgrep      # add one and install it
mise bootstrap packages upgrade
mise bootstrap --only packages --dry-run
```

This list is the curated base, with each machine expecting to vary after that.

`[bootstrap.brew] adopt = true` makes mise take ownership of already-installed
casks instead of replacing the bundle, which is what avoids macOS revoking an
app's Privacy & Security grants.

Third-party taps are listed in `[bootstrap.brew.taps]` with their GitHub URLs.
mise reads tap metadata directly from GitHub and does **not** tap real Homebrew;
non-GitHub taps are unsupported.

## Gotcha: relocating a tool breaks the shell cache

`zsh/plugins/mise/mise.plugin.zsh` uses `cached-eval`, which caches the *output*
of `mise activate zsh` under `~/.cache/zsh/cached-eval/`. That output contains
the **absolute path** of the binary. Move or reinstall a cached tool and every
new shell errors:

```
_mise_hook:1: no such file or directory: /opt/homebrew/bin/mise
```

The cache does not notice the binary moved. Clear the stale entry; it
regenerates on the next shell:

```sh
rm ~/.cache/zsh/cached-eval/mise.zsh
```

This applies to every `cached-eval` entry — `mise`, `fnox`, `thefuck`,
`intelli-shell`. Find dangling ones with:

```sh
grep -rl '/opt/homebrew/bin' ~/.cache/zsh/cached-eval/
```

## Manual steps mise cannot do

- Add `cliPluginsExtraDirs` to `~/.docker/config.json` so the Homebrew-installed
  docker CLI plugins (compose, buildx) are found.

## Window manager

yabai comes from `asmvik/formulae` (koekeishiya's is archived). skhd is
[skhd.zig](https://github.com/jackielii/skhd.zig), the `jackielii/tap/skhd-zig`
cask, because the original skhd was unstable. It reads the same `skhdrc`.

yabai installs a plist LaunchAgent via `--install-service`. skhd.zig instead
registers the LaunchAgent bundled in `skhd.app` through SMAppService. Both run
from the bootstrap hook. skhd.zig needs a one-time approval in System Settings >
General > Login Items & Extensions; until then `skhd --status` reports
"requires user approval" and no daemon runs.

| Tool | LaunchAgent label |
|---|---|
| yabai | `com.asmvik.yabai` |
| skhd | `com.jackielii.skhd` |

A leftover `~/Library/LaunchAgents/com.koekeishiya.skhd.plist` is from the
original skhd. Remove it, or both daemons run and every hotkey fires twice.

`mru_spaces = false` is set in `mise/config.macos.toml` and is required — with
it on, macOS reorders Spaces by most-recent-use and yabai's space indices move.
