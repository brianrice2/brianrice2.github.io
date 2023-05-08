#! /bin/bash
set -euo pipefail

for file in _posts/*-"$1".md; do
    without_dir=${file#_posts/}
    date=${without_dir:0:10}
    new_file="_posts/${date}-$2.md"
    mv $file $new_file
    echo "Renamed $file to $new_file"
done
