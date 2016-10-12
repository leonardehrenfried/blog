---
layout: post
title: Editing LESS and CSS3 with vim
tags:
- css
- less
- Mixed
- vim
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '758272507'
---
###A thought or two about CSS precompilers

I had heared of Sass repeatedly for a while now but so far I had always mentally filed CSS precompilers under "Interesting concept, but probably not all that useful for me". I thought that CSS is fine as it is and after all it's just a bunch of style definitions, right?

On the other hand I grew to actively dislike handling CSS files. I didn't quite understand at the time that this had mostly to do with their great redundancy and repetition.  When you've been used to something's mediocrity for so long you don't really noticed those weaknesses anymore.

When a coworker suggested using a CSS precompiler to help our <a href="http://stackoverflow.com/questions/2253110/how-to-manage-css-explosion">CSS explosion</a>, I was pretty sceptical. But I like learning new things so we went ahead and introduced <a href="http://lesscss.org/">LESS</a> in our current project.

What a difference! I may end up sounding like a used-car salesman but it really is a difference like day and night. I'd love to tell you lots of reasons why these precompilers are great, but unfortunately Jason Z. from 37 signals has done a <a href="http://37signals.com/svn/posts/3003-css-taking-control-of-the-cascade">much better job</a>.

###Wasn't this post suppossed to be about vim?

Lets talk business then. I'm using vim to edit LESS and it looks like this:

![Alt text](https://github.com/leonardehrenfried/vim-less/raw/master/screenshot.png)

I can recommend a trio of plugins for LESS and general CSS3 editing:

####[vim-less](https://github.com/groenewege/vim-less)

This plugin's syntax highlighting was fairly feature-rich to begin with but I have added a few extra features including indenting and autocompletion and the original author has merged them back to his branch. The plugin's compatibility has led me to check out vim-css-colors.

####[vim-css-colors](https://github.com/skammer/vim-css-color">vim-css-colors)

This great plugin visualises a color expressed in hex, RGBa or HSLa and paints the background underneath it in the corresponding color. If you're not sure what I mean, here's screenshot:

![Alt text](https://github.com/skammer/vim-css-color/raw/master/Screen%20shot%202010-07-04%20at%200.19.46.png)

This may look like a toy to some, but LESS lets you have a file with just the colour palette of your app/website and seeing them all visualised is very nice. It also helps you to reuse the same variable name for each colour rather than re-introducing new ones.

####[vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax)

This has a very complete syntax file for CSS3 and I have  added support for this plugin in vim-less. That works pretty well and those fancy new CSS3 properties are then also displayed with correct syntax highlighting applied.

###Improvements for the future

The current autocomplete (hit Ctr-X, Ctrl-O if you've never used it) that ships with standard vim is pretty complete for CSS2. However there is no autocomplete script for CSS3. Looking at the <a href="http://code.google.com/p/vim/source/browse/runtime/autoload/csscomplete.vim">CSS2 version</a>, it shouldn't actually be too hard to parse the syntax highlight files and add the new properties to the existing script.

I'd also like to implement a syntax checker but looking the the source of lessc, LESS' command line compiler, there doesn't seem to be a validating phase that I could use.

I also saw that some web-based CSS prettifyiers can order CSS properties alphabetically. Wouldn't that be a neat feature for vim?
