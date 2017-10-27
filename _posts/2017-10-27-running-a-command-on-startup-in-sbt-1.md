---
layout: post
title: Running a task on startup in sbt 1.0
type: post
tags:
  - scala
  - sbt
published: true
---

If you want to run a task on startup in sbt 0.13 you'd probably do something
like this:

```scala
onLoad in Global := (Command.process("project server", _: State)) compose (onLoad in Global).value
```

This changes into the the subproject `server` after sbt has loaded.

In sbt 1.0 `Command.process` has been removed and to achieve the same thing, 
you now have to do this:

```scala
onLoad in Global ~= (_ andThen ("project server" :: _))
```
