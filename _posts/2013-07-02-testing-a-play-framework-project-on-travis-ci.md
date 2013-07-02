---
layout: post
title: How to test a Play framework project on Travis CI
tags:
- play
- testing
- ci
type: post
published: true
---

Setting up a Travis CI build job for a Play project isn't quite as
straightforward as I had hoped. There are some guides floating around the
web telling you to download the binary distribution and execute that.

I, however, found that it is easier, quicker and cleaner to use the `sbt`
command that comes preinstalled with the Travis VMs. (The `play`
command is just a thin wrapper around `sbt` anyway.)

What it boils down to is this `.travis.yml`:

```yaml
language: scala
scala:
   - 2.10.0
script: sbt test
notifications:
  email:
    on_success: never
    on_failure: change
```

You will also need to make sure that you have specified at least version
`0.12.3` of sbt in your `build.properties`:

```
sbt.version=0.12.3
```
I found that with earlier sbt versions I would get a weird error whereby a
`slf4j-api` dependency couldn't be resolved.

[`commercetools/sphere-snowflake`](https://github.com/commercetools/sphere-snowflake)
is an example Github repository of a Play project being tested on Travis.
