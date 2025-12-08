default:
    @just --justfile {{ justfile() }} --list

# Gets all pods the given service is associated with
service-pods service $namespace='':
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ -n "$namespace" ]]; then
        namespace="-n $namespace"
    fi
    kubectl ${namespace} get endpoints {{ service }} -o jsonpath='{.subsets[*].addresses[*].ip}' \
        | tr ' ' '\n' \
        | xargs -I % kubectl ${namespace} get pods --field-selector=status.podIP=%

# Gets the diff between two deployment revisions
rollout-revision-diff deployment rev1 rev2 $namespace='':
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ -n "$namespace" ]]; then
        namespace="-n $namespace"
    fi
    delta \
        <(kubectl ${namespace} rollout history deployment {{ deployment }} --revision {{ rev1 }}) \
        <(kubectl ${namespace} rollout history deployment {{ deployment }} --revision {{ rev2 }}); true
