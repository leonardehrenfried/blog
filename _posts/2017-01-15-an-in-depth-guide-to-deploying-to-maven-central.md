---
layout: post
title: An in depth guide to deploying to Maven Central with sbt
type: post
tags:
  - scala
  - scalajs
published: true
---
So, you've written a library or program in Java or Scala (or any other JVM language) and want to deploy it so that others can use
it without configuring extra repos? Just deploy it to Maven Central! This repository of code artifacts and their metadata
is _the_ place to publish your code as virtually all JVM build systems pull their dependencies from there.

I published my first artifact to Maven Central with Maven (the tool, not the repository format) in 2011 and back then it was
an extremely complicated process.

In 2016 I did it again with `sbt` and `mvn` and was pleasantly surprised about how much the process had been streamlined.

In this blog post I'm going into detail about how to deploy an artifact with sbt.

### Sonatype

Only very few projects deploy to Maven Central directly. Most small projects these days deploy to Maven Central via the
[Sonatype Repository](http://central.sonatype.org/pages/ossrh-guide.html). This in turn then syncs with Maven Central.

There is an [official guide](http://www.scala-sbt.org/release/docs/Using-Sonatype.html) on how to do that with sbt but
we are going to use a couple of plugins so we don't have to use the confusing UI of the Sonatype Repository. (At least it was confusing
when I used it last in ~2011.)

### sbt setup

Add the following plugins to your `project/plugins.sbt`:

```scala
addSbtPlugin("org.xerial.sbt" % "sbt-sonatype" % "2.3")

addSbtPlugin("com.jsuereth" % "sbt-pgp" % "1.1.1")
```

and the following keys to your project settings in your main `build.sbt`:

```scala
// POM settings for Sonatype
organization := "com.example"
homepage := Some(url("https://github.com/username/projectname"))
scmInfo := Some(ScmInfo(url("https://github.com/username/projectname")
                            "git@github.com:username/projectname.git"))
developers := List(Developer("username",
                             "User Name",
                             "mail@username.de",
                             url("https://github.com/username")))
licenses += ("Apache-2.0", url("http://www.apache.org/licenses/LICENSE-2.0"))
publishMavenStyle := true

// Add sonatype repository settings
publishTo := Some(
  if (isSnapshot.value)
    Opts.resolver.sonatypeSnapshots
  else
    Opts.resolver.sonatypeStaging
)
```

Obviously replace the placeholder values appropriately.

### GPG keys

In order to be on Maven Central your artifacts have to be signed with PGP. If you already have a PGP key, great! If not create one with:

```
sbt pgp-cmd gen-key
```

Then deploy this key to a key server

```
pgp-cmd send-key ${keyname} hkp://pool.sks-keyservers.net
```

There are a few key servers around the internet and every few hours they syncronise with
each other so eventually all keys will be on all servers. Sonatype and Maven/Ivy clients
will validate the signature on the artifact with your public key to make sure it is exactly what you have published.

### Sonatype account

You need to make an account at the Sonatype repo: [https://issues.sonatype.org/secure/Signup!default.jspa](https://issues.sonatype.org/secure/Signup!default.jspa)

They usually takes a few hours to respond and will ask you if you own the domain of your group id. If you don't then maybe
use the domain of the provider where you host the code such as `com.github.username` as your group id.

After a while the ticket will be closed and you'll be told that you now can publish into your group id.

### Configure credentials

Create a file `$HOME/.sbt/(sbt-version)/sonatype.sbt`

Set Sonatype account information (user name and password) in the global sbt settings. To protect your password,
never commit this file to your SCM.

``` scala
credentials += Credentials("Sonatype Nexus Repository Manager",
        "oss.sonatype.org",
        "(Sonatype user name)",
        "(Sonatype password)")
```
### Publishing

Once you have the permission to upload you can simply run

```
sbt publishSigned
```

This will sign and upload your artifact to Sonatype's staging repository. If you want you can test this release first by adding the repo to your `build.sbt`.

If you're happy with the release and want to push to Maven Central run

```
sbt sonatypeRelease
```

This promotes the release to be ready for synching to Maven Central. It usually takes a few hours before it will show up in http://search.maven.org/ but the actual sync job runs every hour or so.

Now head over to the [Maven search](https://search.maven.org/) to check out your artifact.

