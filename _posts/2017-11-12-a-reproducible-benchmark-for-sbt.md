---
layout: post
title: A reproducible benchmark for sbt
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

I took an sbt project provided by [Sam Halliday](https://github.com/fommil) that 
had pathologically bad performance.

The problem with this project is its very large classpath and many
submodules - it contains almost no source code itself!
Before compilation even starts a large amount of time is spent on checking
if classpath entries have changed.

Around this test repository wrote a little bit of tooling for executing and timing
sbt commands and running them with various sbt versions.

The benchmark sets sbt up to download all the required dependencies before the 
actual task under benchmark in order to ensure fairness. It then benchmark
tasks with various sbt versions and measures execution times.

## Results

The timing results are as follows:

|command|sbt 0.13.16|sbt 1.0.3|
|--- |--- |--- |
|startup|37 seconds|45 seconds|
|compile once |89 seconds|129 seconds|
|compile twice|107 seconds|189 seconds|

The results are clear: sbt 1.0.0 has seen a substantial slowdown - at
least for this particular use case.

In case you're wondering, these benchmarks were run on a 2015 Macbook Pro with
a 2.9 GHz Intel Core i5 and 16 GB of RAM.

## Future work

I'm planning on tracking and comparing the performance of future sbt versions.
In particular, 1.0.4 is going to be released very soon and has some performance
improvement patches.

The benchmark can also be extended with more test case to give insights into a
wide range of performance scenarios. Contributions are very welcome!

## Links

- [Benchmark repository on Github](https://github.com/leonardehrenfried/sbt-performance-benchmark)
- [Raw results in JSON format](https://github.com/leonardehrenfried/sbt-performance-benchmark/blob/master/reports/large-classpath-2017-11-10T23:09:08.604Z.json)
- [Original performance regression demo repo](https://github.com/cakesolutions/sbt-cake/tree/sbt-perf-regression)

