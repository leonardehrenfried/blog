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
command that comes preinstalled with the Travis VMs if you set the language to
`scala`. (The `play` command is just a thin wrapper around `sbt` anyway.)

What it boils down to is this `.travis.yml`:

```yaml
language: scala
scala:
   - 2.10.0
script: sbt test
```

You will also need to make sure that you have specified at least version
`0.12.3` of sbt in your `build.properties`:

```
sbt.version=0.12.3
```
I found that with earlier sbt versions I would get a weird error whereby a
`slf4j-api` dependency couldn't be resolved.

####Using the play command

Today I also got a second variation working by downloading the Play zip
distribution and running that.

```yaml
language: scala
env:
  - PLAY_VERSION=2.1.1
before_script:
  - wget http://downloads.typesafe.com/play/${PLAY_VERSION}/play-${PLAY_VERSION}.zip
  - unzip -q play-${PLAY_VERSION}.zip
script: play-${PLAY_VERSION}/play test
```
This takes a little longer but runs the tests in the way a developer is
advised by Play documentation to do it. I think either way is fine.

You must make absolutely sure that you are using the same Play version in
your `travis.yml` and the `play-sbt-plugin` in your `build.sbt`.

####Example project

[`commercetools/sphere-snowflake`](https://github.com/commercetools/sphere-snowflake)
is an example Github repository of a Play project being tested on Travis.
