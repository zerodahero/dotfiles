#
# Completion styles that must land after ez-compinit applies its compstyle.
#
# .zstyles is sourced before antidote loads ez-compinit, and ez-compinit runs
# run-compstyleinit at load time, so anything compstyle_zshzoo_setup also sets
# gets overwritten there. zshrc.d is deferred, so it loads strictly later and
# these win.
#
# Both of these are in the prez and gremlin compstyles but not in zshzoo.
#

# Cache slow completers.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Complete ssh/scp/rsync hosts from ~/.ssh/config and known_hosts.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
  ${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//,/ }
)'
