---
layout: post
title: Two tips for writing tests for the play framework
tags:
- vim
- scala
type: post
published: false
---
Here is a collection of small collection of things that I gathered when I
wrote a medium size app with the Play framework. In no particular order, here
they are:

#####Completely disabling Scaladoc generation during "sbt stage"

```scala
publishArtifact in (Compile, packageDoc) := false,
sources in doc in Compile := List(), //completely disable scaladoc generation during `sbt stage`
```

#####Enable the mock SMTP mode of the play-mailer-plugin

```scala
"test email sending" in {
  running(FakeApplication(additionalConfiguration = Mock("smtp.mock", "true"))) {
    //do your tests here
  }
}
```
