#!/bin/bash
set -u

HAML_FILES=$(jj diff --name-only -r main..@ -- 'root-glob:**/*.haml')
RUBY_FILES=$(jj diff --name-only -r main..@ -- 'root-glob:**/*.rb')
TS_FILES=$(jj diff --name-only -r main..@ -- "root-glob:'**/*.{js,jsx,ts,tsx}'")

if [[ -n "$HAML_FILES" ]]; then
  echo "Running haml-lint"
  echo "-----------------"
  echo "$HAML_FILES" | xargs haml-lint
  printf "\n\n"
fi

if [[ -n "$RUBY_FILES" ]]; then
  echo "Running rubocop"
  echo "---------------"
  echo "$RUBY_FILES" | xargs rubocop -A --force-exclusion
  printf "\n\n"
fi

if [[ -n "$TS_FILES" ]]; then
  echo "Running eslint"
  echo "--------------"
  echo "$TS_FILES" | xargs ./node_modules/eslint/bin/eslint.js --cache --fix
  printf "\n\n"

  echo "Running ts_check"
  echo "----------------"
  pnpm tsc -p tsconfig.json --noEmit && pnpm tsc-strict -p tsconfig.strict.json
  printf "\n\n"
fi
