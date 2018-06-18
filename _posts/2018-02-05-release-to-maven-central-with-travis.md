---
layout: post
title: Release to Maven Central with Travis
published: false
tags:
  - scala
---

```
mkdir keys
cd keys
gpg --homedir . --gen-key
gpg --homedir . --keyserver pgp.mit.edu --send-key F09EE334
gpg --homedir . --export > all.gpg
travis encrypt-file all.gpg --add
```

