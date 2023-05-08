#! /bin/bash
set -euo pipefail

FILENAME="_posts/$(date +"%Y-%m-%d")-new-post.md"

cat << EOF > "${FILENAME}"
---
toc: false
layout: post
description:
categories: []
title:
---

EOF

echo "Created $FILENAME"
