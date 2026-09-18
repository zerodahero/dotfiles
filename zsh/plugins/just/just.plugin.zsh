#
# just: module-aware completion
#
# just ships a clap_complete dynamic completer (`just --completions zsh` is a
# four-line shim around it). That completer returns fully-qualified recipe
# paths -- `env::dev::probe` -- and returns the same list at every argument
# position. So `just env <TAB>` re-offers the whole justfile instead of
# narrowing to the `env` module, while `just env::<TAB>` works only because zsh
# filters the flat strings by the typed prefix.
#
# This wraps the upstream completer rather than replacing it. Once the typed
# words put you inside a module, it offers that module's next path segment.
# Everything else -- the justfile root, flags, recipe arguments, the `::` form
# -- is handed straight back to upstream, so files, directories and variables
# keep completing the way they do today.
#
# just accepts `just env dev probe` and `just env::dev::probe`, but rejects the
# mixed `just env dev::probe`, so completion advances one segment at a time.
#

function _just_modules() {
  emulate -L zsh
  setopt local_options extended_glob

  # The upstream completer lives inside the just binary. Source it once, then
  # take back the `compdef` registration it performs on its way out.
  if (( ! $+functions[_clap_dynamic_completer_just] )); then
    source <(JUST_COMPLETE=zsh command just 2>/dev/null) 2>/dev/null
    compdef _just_modules just
  fi
  (( $+functions[_clap_dynamic_completer_just] )) || return 1

  # Nothing typed yet, so there is no module to narrow into. Skip straight to
  # upstream rather than fetching a candidate list we would only throw away.
  if (( CURRENT <= 2 )) || [[ $words[CURRENT] == *::* ]]; then
    _clap_dynamic_completer_just "$@"
    return
  fi

  # Pass the whole command line through, so `--justfile` and
  # `--working-directory` in the `.j` / `.w` / `.k` aliases are honoured.
  local -a raw
  raw=( ${(f)"$( _CLAP_IFS=$'\n' \
                 _CLAP_COMPLETE_INDEX=$(( CURRENT - 1 )) \
                 JUST_COMPLETE=zsh \
                 command just -- "${words[@]}" 2>/dev/null )"} )

  if (( ! $#raw )); then
    _clap_dynamic_completer_just "$@"
    return
  fi

  # Split each candidate into path and description. just escapes the module
  # separator as `\:\:`; descriptions may contain unescaped colons.
  # Note: `path` is zsh's $PATH array, so never use it as a local name here.
  local line rpath desc
  local -a rpaths descs
  for line in $raw; do
    if [[ $line =~ '^((\\.|[^:\\])*):(.*)$' ]]; then
      rpath=$match[1]; desc=$match[3]
    else
      rpath=$line; desc=
    fi
    rpaths+=( ${rpath:gs/\\:/:} )
    descs+=( "$desc" )
  done

  # Find which module the typed words put us in. A module path is always
  # rooted and always sits at the end of the line, so test each trailing run of
  # words longest-first and take the first one that is a real module prefix.
  # Flags and their values fall out for free: `--justfile::env` matches nothing.
  local pre="" try
  local -a segs opts
  integer start best=0 i
  for (( start = 2; start < CURRENT; start++ )); do
    try="${(j'::')words[start,CURRENT-1]}"
    if (( ${rpaths[(I)${(b)try}::*]} )); then
      best=$start
      break
    fi
  done

  # Not inside a module: the justfile root, a recipe's arguments, or a bare
  # flag. Upstream's list also carries files, variables and flags that this
  # function does not model, so hand all of it back.
  if (( ! best )); then
    _clap_dynamic_completer_just "$@"
    return
  fi
  segs=( "${(@)words[best,CURRENT-1]}" )
  opts=( "${(@)words[2,best-1]}" )
  pre="${(j'::')segs}::"

  # Module docs are not in the completer's output, so pull them from --list.
  # Best effort: a missing doc just means a bare module name.
  local -A docs
  local nm
  for line in ${(f)"$( command just "${opts[@]}" --list-heading "" \
                       --list-prefix "" --list "${segs[@]}" 2>/dev/null )"}; do
    [[ $line == *' # '* ]] || continue
    nm=${line%% *}
    docs[$nm]=${line#*\# }
  done

  # Keep the candidates under the current module, strip the prefix, then split
  # the remainder on its first `::` to get the next segment.
  local rest seg
  local -a mods recs
  local -A seen
  integer plen=$#pre
  for (( i = 1; i <= $#rpaths; i++ )); do
    rpath=$rpaths[i]
    [[ ${rpath[1,plen]} == ${(b)pre} ]] || continue
    rest=${rpath[plen+1,-1]}
    if [[ $rest == *::* ]]; then
      seg=${rest%%::*}
      (( $+seen[$seg] )) && continue
      seen[$seg]=1
      mods+=( "${seg}${docs[$seg]:+:${docs[$seg]}}" )
    else
      recs+=( "${rest}:${descs[i]}" )
    fi
  done

  (( $#mods )) && _describe -V 'module' mods
  (( $#recs )) && _describe -V 'recipe' recs
  (( $#mods + $#recs )) || _clap_dynamic_completer_just "$@"
}

compdef _just_modules just
