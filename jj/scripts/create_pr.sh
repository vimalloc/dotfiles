#!/bin/bash
set -euo pipefail

NEAREST=$(jj log --no-graph -r "previous_bookmark(@)" -T 'bookmark_name')
jj git push -b "$NEAREST"
