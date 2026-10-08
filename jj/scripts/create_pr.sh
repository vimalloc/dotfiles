#!/bin/bash
set -euo pipefail

NEAREST=$(jj log --no-graph -r "previous_bookmark(@)" -T 'bookmark_name')
PARENT=$(jj log --no-graph -r "previous_bookmark($NEAREST, minus)" -T 'bookmark_name')

if [[ -z "$PARENT" ]]; then
  gh pr create --fill --draft --assignee "@me" --head "$NEAREST"
else
  gh pr create --fill --draft --assignee "@me" --head "$NEAREST" --base "$PARENT"
fi
