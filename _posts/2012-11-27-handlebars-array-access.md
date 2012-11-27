---
layout: post
title: Handlebars array access
tags:
- javascript
- html
type: post
published: true
---

I keep forgetting and regoogling this and apparently it isn't documented anywhere
I could find it, so I'm going to write it down hoping that Google will
help spread the word.

####So, how do I access an array in a Handlebar template?

The syntax is the following: `{{ "{{ array.[index] " }}}}`

####An example from an app I'm building right now

    <div class="img-container pull-left">
     {{ #if imageURLs.length " }}
        <img src=""{{ imageURLs.[0] " }}"/>
      {{ else }}
        <img src="http://placehold.it/130x130" class="img-polaroid">
      {{ /if }}
    </div>


