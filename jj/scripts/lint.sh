#!/bin/bash
set -euo pipefail

# TODO - print linter names if files exist. Run tschek if js files changed.

jj diff --name-only -r main..@ -- 'root-glob:**/*.rb' | \
  xargs rubocop -A --force-exclusion
jj diff --name-only -r main..@ -- "root-glob:'**/*.{js,jsx,ts,tsx}'" | \
  xargs ./node_modules/eslint/bin/eslint.js --cache --fix
jj diff --name-only -r main..@ -- 'root-glob:**/*.haml' | \
  xargs haml-lint

