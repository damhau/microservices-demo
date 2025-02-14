#!/usr/bin/env bash
set -Eefuo pipefail

dockerImageNoTag="${IMAGE%:*}"

podman build --env=http_proxy=http://globalproxy.gva.icrc.priv:8080 --env=https_proxy=http://globalproxy.gva.icrc.priv:8080  --tag="$IMAGE" --cache-from="$dockerImageNoTag" "${BUILD_CONTEXT:-.}"

if [[ "${PUSH_IMAGE}" == "true" ]]; then
    echo "Pushing $IMAGE"
    podman push "$IMAGE"
else
    echo "Not pushing $IMAGE"
fi