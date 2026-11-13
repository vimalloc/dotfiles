#!/bin/bash
set -euo pipefail

jj bookmark advance
./push_nearest.sh
