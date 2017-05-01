---
layout: post
title: Gitlab CI caching for sbt projects
type: post
tags:
  - scala
  - sbt
  - gitlab
published: true
---

Compiling and testing `sbt` projects on hosted CI platfroms like Travis and Gitlab CI is dominated by downloading
the required dependencies from Maven Central.

Oftentimes you have four to five minutes of downloading and less than one minute of compiling and testing.

Some offer a caching feature which is supposed to speed up these always-the-same download tasks by caching
the dependencies in an S3 bucket.

Caching dependencies for Scala in Travis is relatively straight forward however I couldn't find an example
to do this for Gitlab CI. After a lot of trial and error I figured it out.

Here is the `.gitlab-ci.yml`:

```yaml
# some parts originally from https://github.com/randm-ch/units-of-information/blob/master/.gitlab-ci.yml

image: "hseeberger/scala-sbt"

variables:
  SBT_VERSION: "0.13.9"
  SBT_OPTS: "-Dsbt.global.base=sbt-cache/.sbtboot -Dsbt.boot.directory=sbt-cache/.boot -Dsbt.ivy.home=sbt-cache/.ivy"

cache:
  key: "$CI_BUILD_REF_NAME" # contains either the branch or the tag, so it's caching per branch
  untracked: true
  paths:
    - "sbt-cache/cache/.ivy"
    - "sbt-cache/.boot"
    - "sbt-cache/.sbtboot"
    - "sbt-cache/target"

stages:
  - test

test:
  script:
    - sbt test
```

Sometimes it takes a few times for it to actually work so just commit it and try it a few times.
