#!/bin/bash
set -euo pipefail

NEAREST=$(jj log --no-graph -r "previous_bookmark(@)" -T 'bookmark_name')

if [[ -z "$NEAREST" ]]; then
  echo "No bookmarks"
  exit 0
fi

jj diff --from "$NEAREST" --to "$NEAREST@origin"
