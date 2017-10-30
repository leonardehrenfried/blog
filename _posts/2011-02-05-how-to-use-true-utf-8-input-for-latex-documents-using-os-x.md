---
layout: post
title: How to use true UTF-8 input for Latex documents (using OS X)
tags:
- latex
- Mixed
- unicode
- utf-8
- xetex
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _wp_old_slug: ''
  dsq_thread_id: '765766252'
---
LaTex is a great typesetting system. It (or at least its predecessor) was written by probably the [most famous programmer](http://www-cs-faculty.stanford.edu/~uno/) still living. Once you grokked the syntax it is simple to create really complex documents with cross references and to split up the input into multiple files like you would do with a large program. If you like document creation which uses plain text input rather than some fancy-shmancy WISYWIG tool, LaTex is for you.

However, the ordinary LaTex distribution has a big drawback: It can only use ASCII as its input encoding. There was a hack that would let you could use Unicode characters in your document by preprocessing the file and replacing all non-ASCII characters with their escaped counterpart, but that was ugly and just that - a hack. Even worse, some characters (namely from Asian languages) do not have an escaped form so they could not be used in LaTex, full stop.

### TexLive

This problem was solved by a Tex distribution that supports the full range of Unicode characters: [Xetex](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=xetex). It was originally written for OS X only but has since been ported to a range of platforms.
Xetex allows you to type set a document using all of UTF-8 supported scripts without nasty hackery, as seen in the following screenshot.

![Typesetting Arabic](http://scripts.sil.org/cms/sites/nrsi/media/xetex_unicode_arabic.png)

Some additional features, which might or might not be interesting for you, are improved font support for OTF files and some advanced ligatures features. All of this might not rock your world but it is all nice to know that it is there. In short XeTex is a modern Tex system.

### Installation and invokation
Xetex has since 2007 been incorporate by the TexLive distribution. There is an ordinary installation package for OS X but I prefer to use Macports for my package management, so I will walk you through that. First of all install the texlive base package with a

    sudo port install texlive

Sit back, this will take a while. The command installs the binaries and a "medium" amount of packages, however, if you are a heavy user you probably use a lot of extra packages. I for one needed the 'sectsty' package and had to install additional ports for that.

    sudo port install texlive-latex-extra

If you are looking for a specific LaTex package but don't know which port it is in grep the [list of packages](https://trac.macports.org/wiki/TeXLivePackages).

After the installation you will be able to compile LaTex documents with the following command:

    xelatex input.tex

The default out put is PDF, so if you want something different, go and check the manual.
### Gotchas
XeTex assumes that you will feed it UTF-8 characters natively so the above-mentioned encoding hacks won't be necessary and will trip up XeTex. Just remove lines like these:
{% highlight latex %}\usepackage[utf8]{inputenc}{% endhighlight %}
