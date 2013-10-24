---
layout: post
title: Find out who the maintainer of a Debian/Ubuntu package is
type: post
tags:
  - ubuntu
  - debian
published: false
---
```bash
dpkg-query -W -f='${Maintainer}' coreutils
```
