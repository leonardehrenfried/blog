---
layout: post
title: A reprocible benchmark for sbt
tags:
  - scala
  - sbt
  - benchmark
---

A few weeks ago sbt version 1.0.0 has been released. One of the big ticket
items in this release has been an improved incremental compiler that needs
to compile less and therefore is faster. Slow builds are a common complaint
for Scala developers so this generated a lot of excitement.

In reality however, build times in version 1.0.0 have not seen any improvement
but rather a significant slow down. While the incremental compiler itself
_is_ faster, other areas of sbt have seen a sudden worseing of performance.
This has been reflected in a [flurry](https://github.com/sbt/zinc/pull/452) of 
[Github tickets](https://github.com/sbt/zinc/pull/371) and discussions on the
Gitter channel.

The sbt core developers have been understandably reluctant to merge in spurious
pull requests by the community without evidence that they really improve
performance beyond a simple micro benchmark.

The Scala compiler, for example, has a solid [performance benchmark](https://developer.lightbend.com/blog/2017-06-12-faster-scala-compiler/#benchmarking) 
suite that is run on every commit and gives immediate feedback about proposed changes.

Something along these lines is needed for sbt, too.

Since there doesn't seem to be anything around yet, I took upon me to write 
one.

## Methodology

I took an sbt project provided by Sam Halliday that had pathologically bad
performance, wrote a little bit of tooling around executing and timing 
sbt commands and running them with various sbt versions.

The benchmarking code is available on [Github](https://github.com/leonardehrenfried/sbt-performance-benchmark).

## Results

The problem with the test sbt project is its very large classpath and many
submodules - it contains almost no source code itself! 
Before compilation even starts a large amount of time is spent on checking
if classpath entries have changed.

The benchmark sets sbt up to download all the required dependencies in order
to ensure fairness.

|command|0.13.16|1.0.3|
|--- |--- |--- |
|prefillCache|87 seconds|125 seconds|
|startup|37 seconds|45 seconds|
|compile|89 seconds|129 seconds|
|compileTwice|107 seconds|189 seconds|..

  

The results are clear: sbt 1.0.0 has seen a substantial slowdown - at
least for this particular use case.

I'm hoping this has 

Raw results with information are also available [in JSON format](https://github.com/leonardehrenfried/sbt-performance-benchmark/blob/master/reports/large-classpath-2017-11-10T23:09:08.604Z.json).




