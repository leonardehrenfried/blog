---
layout: post
title: Mavens's "The artifact has no valid ranges"
tags:
- apache
- error
- java
- maven
- Mixed
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '761564810'
---
I have just learned to use the really great Java build and project management tool [Maven][1]. It makes managing large projects with dozens of components a lot easier and its build configuration is simpler and less imperative compared to Ant, since it relies a lot on convention over configuration. Basically, Maven knows that pretty much every project needs to be

*   compiled
*   JavaDoc'd
*   unit tested

These things don't need to be declared and are automatically done by Maven. Maven's great advantage over Ant is it's ability to handle the dependencies of your project, ie. the old "Hunt the JAR" game is a thing of the past as Maven will simply download whatever libraries or frameworks you will need. Most of the time your build will run smoothly and Maven will spit out a nice JAR or WAR without problems.

### The curious error message

However, if there are build errors they tend to be on the cryptic side. "The artifact has no valid ranges" is one of those. Basically it means that you *do have* a valid range, however you have defined two (or more) *different version ranges of an artifact* in a fixed way. Most likely you haven't defined those dependencies in the same project but through a transitive dependency.

Let's have an example. Your project *my-app*, depends on an artifact *super-framework* at version 1.0, and only 1.0, nothing else. *my-app* also depends on another of your apps called* my-app2*. *my-app2* has a dependency on *super-framework* but only for versions 0.5 to 0.9. This means that you have incompatible version ranges and you need to resolve this. You will have to edit *my-app* or *my-app2* and change their version ranges for *super-framework*.  This took me a little while to figure out myself since the error kinda suggests to look in the wrong place. The range is perfectly valid, it's just that there is too many of them.

### Debugging this message

That is a little tricky. You can try running Maven with the -X flag, which will show a running log of how the version is chosen. Also, sometimes the Maven plugin for Eclipse can give you some clues, but sometimes it is way off. One word of advice though, it seems to matter in which order you include your dependencies in the the POM file. So, if you include a dependency on `super-framework [0.5,1.5)` it will fetch the latest available version, say 1.1. If you then have a transitive dependency further down that includes `super-framework [0.5, 1.0)` Maven will generate this misleading error, since it will not select anything other than the 1.1 it already has, even though it could just select 0.9 without producing a version conflict. If you swap the order, weirdly, it works.

 [1]: http://maven.apache.org/
