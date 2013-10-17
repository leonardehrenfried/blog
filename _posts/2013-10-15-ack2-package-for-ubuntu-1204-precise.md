---
layout: post
title: ack2 package for Ubuntu 12.04
type: post
published: true
---


Ubuntu 12.04 Precise Pengolin ships with version 1.96 of
[ack](http://beyondgrep.com) which has been superseded by the much improved
version 2. Read the [ack homepage](http://beyondgrep.com/ack-2.0/) if you want
to find out what is new in ack 2.

Since I'm now using Ubuntu on my work computer I have built a Debian/Ubuntu
package and uploaded it to a PPA. This makes installing ack2 really easy on
Ubuntu 12.04.

If you want to install it do the following:

```
sudo add-apt-repository ppa:leonard-ehrenfried/ack2
sudo apt-get update
sudo apt-get install ack-grep
```

Afterwards, ack will be available as `ack-grep` (there is another program in
the Ubuntu repositories using the name ack).

Since I share my `.bashrc` between OS X and Linux I've aliased it as follows:

```bash
if [ `uname` == "Linux" ]
then
  alias ack="ack-grep"
fi
```
