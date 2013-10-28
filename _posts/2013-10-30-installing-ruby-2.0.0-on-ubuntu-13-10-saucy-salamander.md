---
layout: post
title: Installing Ruby 2.0 on Ubuntu 13.10 Saucy Salamander (without RVM)
tags:
- ruby
- ubuntu
type: post
published: true
---

Ubuntu 13.10 has been released recently being a cutting-edge addict the first
thing I tried was the new Ruby versions.

The sad news is that the default on Saucy is Ruby 1.9.3. (At least it's no
longer 1.8!)

Interestingly, though, an easily installed version of Ruby 2.0 is available
in the default repos. This means you don't have to use monstrosities like
RVM in order to get the newest Ruby binaries on your system.

The trick is to know that the package is called `ruby2.0`. Here are the complete
installation instructions:

```bash
sudo apt-get update

sudo apt-get install ruby2.0 ruby2.0-dev build-essential \
  libssl-dev zlib1g-dev ruby-switch
```

Even though the dev and compiler packages (`build-essential`) aren't strictly
necessary to run Ruby code you'll probably need them to install gems that
contain C code.

Note that the `rubygems` package is gone. The `gem` command is now included
in the `ruby2.0` package.

If you have multiple Rubies installed you can make 2.0 the default by doing
the following:

```bash
sudo ruby-switch --set ruby2.0
```
Now check which version you are running with a

```bash
ruby --version
```

