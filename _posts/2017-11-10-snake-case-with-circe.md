---
layout: post
title: Snake case keys in Circe
type: post
tags:
  - scala
  - json
  - circe
published: true
---

How to combine Circe's semi-automatic derivation with snake case keys took me a little
while to find out.

You will need to add the circe module: `"io.circe" %% "circe-generic-extras" % "0.8.0"`.

Here is the code:

```scala
import io.circe.generic.extras.Configuration
import io.circe.generic.extras.semiauto._
import io.circe.{Decoder, Encoder}

case class Snaky(someProperty: String)

object Snaky {
  implicit val customConfig: Configuration = Configuration.default.withSnakeCaseKeys.withDefaults
  implicit val snakyEncoder: Encoder[Snaky] = deriveEncoder
  implicit val snakyDecoder: Decoder[Snaky] = deriveDecoder
}
```

