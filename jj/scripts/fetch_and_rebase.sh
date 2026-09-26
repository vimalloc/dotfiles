#!/bin/bash
set -euo pipefail

CURRENT_MAIN=$(jj log --no-graph -r main -T change_id)

jj git fetch

TO_REBASE=$(jj log --no-graph -r "mine_since($CURRENT_MAIN)" -T 'change_id_pipe')
TO_REBASE="${TO_REBASE/%|/}"

jj rebase -b "$TO_REBASE" -o main --skip-emptied
