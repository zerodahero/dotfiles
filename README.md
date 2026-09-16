# dotfiles

Machine setup is driven by [mise](https://mise.jdx.dev). One command provisions
a machine:

```sh
./install.sh          # = cd to this repo, mise bootstrap
```

**Run bootstrap from this repo.** `mise/config.macos.toml` is a project-scoped
config path, so from anywhere else mise silently skips the OS-specific dotfiles
and hooks — 27 entries instead of 34. `install.sh` exists only to guarantee the
`cd`. Tools from `[tools]` work everywhere, via the global config link.

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

# 4. Clone to ~/dotfiles. The path is NOT arbitrary -- see below.
git clone git@github.com:zerodahero/dotfiles.git ~/dotfiles

# 5. Machine identity -- create by hand, see "Machine identity" below
"$EDITOR" ~/.config/mise/config.local.toml

# 6. Everything else
~/dotfiles/install.sh
```

Then open a new shell so activation takes effect.

### The repo must live at `~/dotfiles`

Every `[dotfiles]` source is an absolute `~/dotfiles/...` path, because this
repo is topic-per-directory and its config is reachable by two paths, which
makes relative sources ambiguous.

So **`mise bootstrap --from <url>` does not work here.** It clones to
`$MISE_DATA_DIR/bootstrap-repo`, and every source then fails:

```
mise ERROR files: sources do not exist:
  [dotfiles]."~/.gitconfig": ~/dotfiles/git/config
  ... (all 39)
```

Use the `git clone` above, or `mise bootstrap --from <url> --from-dir ~/dotfiles` if you want the one-liner.

## Machine identity

`~/.gitconfig.local` is rendered from `git/config.local.tmpl` by mise. Do not
edit it — `mise bootstrap` overwrites it. Set the values in
`~/.config/mise/config.local.toml`, which lives outside this repo:

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
| `.miserc.toml` | Sets `MISE_ENV` from `os()`, which selects the file above |
| everything else | Topic directories (`zsh/`, `nvim/`, `git/`, …) linked into place by `[dotfiles]` |

TODO: Add Linux support (add `mise/config.linux.toml`)

## Useful commands

```sh
mise dotfiles status              # per-path: applied / missing / differs
mise dotfiles diff                # what an apply would change
mise bootstrap --dry-run          # the whole plan, executing nothing
mise bootstrap --only dotfiles    # run one phase
mise trust                        # required after cloning or editing config
```

Hooks in `mise/config.toml` run twice when bootstrap is invoked from this repo,
because the file is loaded as both the project and the global config and hook
arrays merge from both. Everything there is idempotent, so the second pass is a
no-op — but do not add a non-idempotent hook to that file.

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

yabai and skhd come from `asmvik/formulae` (koekeishiya's are archived) and
install their own LaunchAgents via `--install-service`, run from the bootstrap
hook. The labels differ, which is confusing but correct:

| Tool | LaunchAgent label |
|---|---|
| yabai | `com.asmvik.yabai` |
| skhd | `com.koekeishiya.skhd` |

`mru_spaces = false` is set in `mise/config.macos.toml` and is required — with
it on, macOS reorders Spaces by most-recent-use and yabai's space indices move.
