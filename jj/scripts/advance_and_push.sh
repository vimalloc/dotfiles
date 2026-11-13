#!/bin/bash
set -euo pipefail

jj bookmark advance
/Users/lily/.config/jj/scripts/push_nearest.sh
