---
layout: post
title: Updating Ubuntu server to the latest beta version (command line edition)
tags:
- beta
- Mixed
- ubuntu
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '880773089'
---
I keep forgetting this, so I'm going to write it down.

Ubuntu can pick up the latest development version with a

    sudo do-release-upgrade -d # -d means development version

But that seems to not pick up any pre-release versions if it isn't configured correctly. You must change the file `/etc/update-manager/release-upgrades` and set

    Prompt=normal
