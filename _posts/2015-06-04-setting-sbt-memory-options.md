---
layout: post
title: Setting sbt memory options
type: post
tags:
  - java
  - sbt
  - xmx
  - xms
published: true
---
If you've been working on a bigger Scala project you will probably have
experienced that SBT consumers a rather large amount of memory and can crash
with a `OutOfMemoryError Metaspace`. There is a lot of advise floating around
the web that tells you to set your memory options in `$SBT_OPTS`.

I learned  that this is only partially true.

What I found out about sbt-launcher version 0.13.8 (the most recent version
at the time of writing) is that setting `Xmx` and friends in `$SBT_OPTS` does
indeed result in them being added to the command line arguments but then they
are overwritten.

The resulting command line invocation looks like this:

```
/usr/bin/java -XX:+CMSClassUnloadingEnabled -Xmx1500M -XX:MaxMetaspaceSize=512m -Xms1024m -Xmx1024m -XX:ReservedCodeCacheSize=128m -XX:MaxMetaspaceSize=256m -jar /usr/local/Cellar/sbt/0.13.8/libexec/sbt-launch.jar
```

You can see that `Xmx` is set twice because the sbt launcher script blindly
prepends the contents of `$SBT_OPTS` to the incovation.

If you put the setting into `$JAVA_OPTS` then the sbt launcher intelligently
parses them but I wanted the memory settings to apply to sbt only and not other
Java applications.

The solution I came up with in the end is to use the `-mem` paramter of sbt
directly.

I've set the following alias

```
alias sbt="sbt -mem 1500"
```

This sets the heap space to 1.5 GB and the MaxMetaspace to 512 MB.

