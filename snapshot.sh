#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INDEX_NAME=$1
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
SNAPSHOT_NAME="${INDEX_NAME}-${TIMESTAMP}"

echo "Creating snapshot as '${SNAPSHOT_NAME}'"

# Will ack even if it already exists
curl -X PUT -d '{"type": "s3", "settings": {"bucket": "elasticsearch-sample-data", "region": "us-east"}}' "http://localhost:9200/_snapshot/s3"
curl -X PUT -d "{\"indices\": \"${INDEX_NAME}\", \"ignore_unavailable\": false, \"include_global_state\": false}" "http://localhost:9200/_snapshot/s3/${SNAPSHOT_NAME}?wait_for_completion=true"
