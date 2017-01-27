#!/usr/bin/env bash

set -o xtrace  # trace what gets executed
set -o errexit # exit when a command fails.
set -o nounset # exit when your script tries to use undeclared variables

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

curl -X PUT -d '{"type": "url", "settings": {"url": "https://elasticsearch-sample-data.s3.amazonaws.com/"}}' "http://localhost:9200/_snapshot/s3_readonly"

for SNAPSHOT_NAME in $(cat ./sample-data-manifest.txt); do
  curl -X POST "http://localhost:9200/_snapshot/s3_readonly/${SNAPSHOT_NAME}/_restore?wait_for_completion=true"
done
