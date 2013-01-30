---
layout: post
title: Editing Scala with Vim
tags:
- vim
- scala
- ctags
type: post
published: true
---

Even though it quite often hurts my brain a little bit, learning Scala has been
a more pleasurable part of my job lately. Even though it isn't for the
faint-hearted it certainly has taught me a lot about thinking precisely about
what my code is doing. This makes me better programmer when programming in a
language other than Scala.

###Tools
Even though the language is beautiful the tools aren't. I'm not really an IDE
lover, quite the opposite, but I have come around to taking a shine to the
comforts that Intelli-J is offering when writing Java.

I was happy to see the Intelli-J has a plugin for Scala development and have
been using that for the last couple of months. Sadly, the plugin is really,
really slow which makes it pretty unusable to me.

###Enter Vim

I'm already using Vim for everything other than Java so I hunted around the
web in order to find plugins and work and I've been quite satisfied with the
following ones.

####[vim-scala]()

####[neocomplcache](https://github.com/Shougo/neocomplcache)

The built-in Vim autocomplete isn't great for Scala.

`~/.ctags`

```bash
--langdef=scala
--langmap=scala:.scala
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private|protected)?[ \t]*class[ \t]+([a-zA-Z0-9_]+)/\4/c,classes/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private|protected)?[ \t]*object[ \t]+([a-zA-Z0-9_]+)/\4/c,objects/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private|protected)?[ \t]*case class[ \t]+([a-zA-Z0-9_]+)/\4/c,case classes/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private|protected)?[ \t]*case object[ \t]+([a-zA-Z0-9_]+)/\4/c,case objects/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private|protected)?[ \t]*trait[ \t]+([a-zA-Z0-9_]+)/\4/t,traits/
--regex-scala=/^[ \t]*type[ \t]+([a-zA-Z0-9_]+)/\1/T,types/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*def[ \t]+([a-zA-Z0-9_]+)/\3/m,methods/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*val[ \t]+([a-zA-Z0-9_]+)/\3/l,constants/
--regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*var[ \t]+([a-zA-Z0-9_]+)/\3/l,variables/
--regex-scala=/^[ \t]*package[ \t]+([a-zA-Z0-9_.]+)/\1/p,packages/
```

Create tags

```bash
ctags -R --exclude=target --exclude=vendor
```
Allow ctags to go up the directory hierarchy

```set tags=tags;/```
