---
layout: post
title: Browsers seemingly adding extra padding below image tags
tags:
- css
- img
- Mixed
- padding-bottom
status: publish
type: post
published: true
meta:
  dsq_thread_id: '759340180'
---
Today I found out about a little CSS quirk/feature (haven't quite decided yet): Image tags are being assigned a seemingly undeserved 5px of padding-bottom.

The weird thing is that this does not show up as padding in Firebug/Web Inspector - my CSS reset had already set it to 0. The image probably illustrates better what I mean - see the little extra space below?

![Invisible bottom margin](https://lh6.googleusercontent.com/-JvElCMCQUMU/ULS68w6S0FI/AAAAAAAAITk/_82kEDE0604/s427/Screen-shot-2010-12-12-at-18.18.33.png)

Well, it turns out that images are inline elements, which means they have extra space at the bottom for the letter 'tails'. These are the lines that go a little lower than the rest in such letters as y, p or q.

The solution is to apply `display:block` to the images in question.
