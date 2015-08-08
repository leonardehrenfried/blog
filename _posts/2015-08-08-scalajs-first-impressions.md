---
layout: post
title: First impressions of ScalaJS
type: post
tags:
  - scala
  - scalajs
published: true
---
My last couple of projects have mostly been written in Scala and I've really
started too love the language as I became better and better at it. Once you've
fully experienced the joy of proper type safety, you can't go back.

However, these days Scala is confined mostly to the server. Since my current
contract also involves a rather large frontend component I also occassionally
have to write JavaScript. Don't get me wrong, I'm not some hapless backend
code slinger dipping his toes into the browser world. Years ago I used the
language a lot and I'm quite competent at it. However after writing a lot of
Scala, JS's weak types really grind on you: they make refactoring
really difficult and you discover many problems, which a compiler would tell
you much earlier, at runtime. :/

Help is at hand: Typesafe is developing [ScalaJS](http://www.scala-js.org/),
which compiles Scala to JavaScript. This weekend I took it for a spin and
here are my observations. (Mind you, this isn't a thorough review but rather a
rough-and-ready stream of consciousness.)

####Nice integration with sbt

You can keep using your build system and IDE. Everything worked out-of-the-box.

####Compiler

The compilation process is not slower than the compiler that targets the JVM.
However, the Scala compiler _is_ quite slow but you get used to it because it
really helps you during development. Those sweet, sweet types are great!

The compiler produces unreadable code which will make debugging harder but
I've read that source maps are available. I haven't been able to make them work
yet.

####Community

It's rather small, but that shouldn't surprise you since ScalaJS has only
come out of beta a few weeks ago. You should expect to write stuff yourself
because it doesn't exist yet.

####Libraries and frameworks

This is currently a weak spot. Obviously, you can use the fantastic Scala
core library which to me is one of the main appeals. I haven't found out how
easy it is to get third party libraries like, say, Joda-Time working.

On the DOM side, there is the nice [scalatags](https://github.com/lihaoyi/scalatags/)
which makes writing HTML typesafe but other than there isn't all that much
around.

The [community seems to be split](https://groups.google.com/forum/#!topic/scala-js/OErQmI2FQRQ)
between people wanting to wrap native JS frameworks like React and others
wanting to write stuff from scratch in pure Scala.

I think we will see a lot of experimentation of approaches and many new
frameworks popping up and eventually dieing. This isn't something that worries
me a lot since this is the way that really make a community thrive. Yes, it
does cause fragmentation to a certain degree but I feel that it's a price worth
paying for finding the best ideas and practises.

####File size

In short: it's acceptable. With fast optimisation my dummy app clocked in at
~600kb. A full optimisation brought that down to around 140kb. Really large
apps probably will be a few MB, but that's not something unheard off with
apps written in native JS, too.

####In summary

I'm very excited about ScalaJS and I think it's very promising. It gets
a lot of things right and people are working on the things that aren't so
great yet.

I might sound like a fanboy, but most things that Typesafe does these days
are very high quality and this is no exception.

If you can tolerate a little technological immaturity and don't mind being an
early adopter, I would seriously consider ScalaJS for you next frontend project.

