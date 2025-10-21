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
