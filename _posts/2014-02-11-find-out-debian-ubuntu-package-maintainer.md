---
layout: post
title: Find out who the maintainer of a Debian/Ubuntu package is
type: post
tags:
  - ubuntu
  - debian
published: true
---
Run the following command:

```bash
dpkg-query -W -f='${Maintainer}' coreutils
```

Obviously, replace `coreutils` with the package you're interested in.
