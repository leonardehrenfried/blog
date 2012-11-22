---
layout: post
title: In praise of Netbeans (and how I learned to hate Eclipse)
tags:
- eclipse
- ide
- java
- Mixed
- netbeans
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '756516164'
---
### The dark ages

I use a MacBook for my development and until recently I have done my Java development in Eclipse. It is a very popular IDE and apparently very flexible and can be made to do absolutely everything. Also, all the Google Java products plugins only worked for Eclipse and that was the main reason for me to not switch. However, it shortcomings became more and more apparent during the time I wrote my dissertation and became more serious about Java development. I noticed the following things about the OS X variant of Eclipse.

1.  **It. Is. Slow.** It is painful to work with an IDE that locks up every 5 minutes and whenever you open a menu that has so far not been opened. I heard something about the Java-Carbon bindings not being very good and I think performance is better on Windows but this was a real issue for me.
2.  **Usability is abysmal.** There are millions of message areas that pop up all the time, buttons are tiny and appear and disappear seemingly randomly. I know software development is supposed to be difficult but this is just unbearably hostile to the user.
3.  **It is very much a Windows app. **It feels a lot like they wrote the app to fit with the windows UI guidelines, realised that there is Mac developers too and just copied the UI button by button. I know us Mac people are demanding when it comes to OS integration but Eclipse is simply not cutting it.

### The conversion

One day I was frustrated enough by how rubbish Eclipse was, that I was ready to switch IDE mid-project. I kept saying to myself that I would give Netbeans a spin at the next project but my patience with Eclipse was wearing thin. I have not looked back. The main issue I was worried about was the project conversion process and I have to tell you it was the most seamless thing I have ever experienced. Absolutely *no errors or incompatibilities* turned up. I was impressed. It also turned out that Netbeans is much better at managing your classpath automatically, so conversion even resolved a few issues. The only thing I had to redo was the tomcat configuration but that took about 30 mins.

### I didn't know Java development could be bearable on a Mac

After trying Netbeans out for a few days I have the following things about it.

1.  **It has a nicer UI**. I know this will not get me any cred with the emacs crowd but if an application doesn't shout "I'M UGLY!" all day long I like using it better than one that does. Call me superficial. I also managed to install a dark editor skin which makes Netbeans resemble Textmate a bit more which has also earned some plus points with me.
2.  **Usability is way better**. Buttons are clear and there are fewer of them. Netbeans also gives you more sane default behaviour so you don't have to poke around in the settings too often.
3.  **Classpath and lib folder management works.** When you put something in the lib folder, it will be put on the classpath and copied into WEB-INF/lib. I couldn't get Eclipse to do that no matter how hard I tried. I had to enable this for every JAR I downloaded.
4.  **It's faster.** Not Textmate-fast but fast enough to not annoy me constantly. I like.
5.  **Mercurial works out of the box.** I didn't install a plugin, I never activated anything. Netbeans just knew I was using it and started marking files as edited. (I guess this works for other SCMs too.)

![Netbeans with Dark Theme](https://lh4.googleusercontent.com/-qVzEt1x470E/T1uo2UfzyhI/AAAAAAAAA88/WTj1G2aC8fo/s912/Netbeans%25206.7.1%2520in%2520action.png)

In retrospect, switching to Netbeans has been a huge boost in terms of productivity for me. I'm wondering why I didn't try it earlier.

