#!/bin/bash
set -u

diff_files() {
  jj diff --summary -r main..@ -- root-glob:"$1" | awk '$1 != "D" { print $2 }'
}

HAML_GLOB='**/*.haml'
RUBY_GLOB='**/*.rb'
TYPESCRIPT_GLOB="'**/*.{js,jsx,ts,tsx}'"

if [[ -n $(diff_files "${HAML_GLOB}") ]]; then
  echo "Running haml-lint"
  echo "-----------------"
  diff_files "${HAML_GLOB}" | xargs haml-lint
  printf "\n\n"
fi

if [[ -n $(diff_files "${RUBY_GLOB}") ]]; then
  echo "Running rubocop"
  echo "---------------"
  diff_files "${RUBY_GLOB}" | xargs rubocop -A --force-exclusion
  printf "\n\n"
fi

if [[ -n $(diff_files "${TYPESCRIPT_GLOB}") ]]; then
  echo "Running eslint"
  echo "--------------"
  diff_files "$TYPESCRIPT_GLOB" | xargs ./node_modules/eslint/bin/eslint.js --cache --fix
  printf "\n\n"

  echo "Running ts_check"
  echo "----------------"
  pnpm tsc -p tsconfig.json --noEmit && pnpm tsc-strict -p tsconfig.strict.json
  printf "\n\n"
fi
