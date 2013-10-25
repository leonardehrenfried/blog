---
layout: post
title: Installing Ruby 2.0 on Ubuntu 13.10 Saucy Salamander (without RVM)
tags:
- ruby
- ubuntu
type: post
published: true
---

```bash
sudo apt-get update

sudo apt-get install ruby2.0 ruby2.0-dev build-essential libopenssl-ruby2.0 \
  libssl-dev zlib1g-dev ruby-switch
```
```bash
sudo ruby-switch --set ruby2.0
```


```bash
ruby --version
```

