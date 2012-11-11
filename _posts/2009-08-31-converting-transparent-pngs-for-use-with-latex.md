---
layout: post
title: Converting transparent PNGs for use with LaTeX
tags:
- alpha
- latex
- Mixed
- png
- transparency
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '756516200'
---
I have recently discovered the power and ease of use of LaTeX and in my last report in included quite a few screenshots of the application I was writing. However OS X's screenshot tool also saves the nice drop shadow that the UI produces around it's windows.

LaTeX on the other hand, doesn't seem to like those drop shadows as they contain transparency (also know as alpha channel) which after the conversion to PDF appears as ugly black borders. Fortunately there is an easy fix for this problem, which I found in a <a title="[unix-dev] mailing list message" href="https://mail.cs.drexel.edu/pipermail/unix-dev/2008-April/001322.html">mailing list message</a>.

You will need to have <a href="http://www.imagemagick.org/">ImageMagick</a> installed for this to work. ImageMagick's convert command line tool allows you to convert the transparent part into proper colours rather than a grey layer with added transparency information (which is what throws the tex-to- PDF converter). Before you add those images to the tex file, convert them like this:
{% highlight bash %}convert -background white -layers merge input.png output.png{% endhighlight %}
