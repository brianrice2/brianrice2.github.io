#! /bin/bash
set -euo pipefail

/usr/local/bin/rename "s/${1}/${2}/" _posts/*.md
