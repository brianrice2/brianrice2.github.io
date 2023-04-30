#! /bin/bash
set -euxo pipefail

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
