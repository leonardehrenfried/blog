---
layout: post
title: What's my Google OpenID URL?
tags:
- google
- Mixed
- openid
- url
status: publish
type: post
published: true
meta:
  _wp_old_slug: googles-url-as-an-openid-provider
  _edit_last: '1'
  dsq_thread_id: '756516218'
---
###Short answer

It's the same for all Google accounts:

    https://www.google.com/accounts/o8/id

Your username is not part of the OpenID.

###Long answer

Well, it seems little strange that Google, your friendly neighbourhood search giant, is so coy about its OpenID support. I had to search around for quite a while to find my OpenID URL, which is the thing you paste into the OpenID box at the service you want to sign up to.

![OpenID URL](https://lh5.googleusercontent.com/-O_Z-n14nWHY/T1uibV54hfI/AAAAAAAAAo8/4fdi-7ZWKog/s295/Logging%2520in%2520with%2520an%2520OpenID%2520URL.jpg)

Why is Google doing this, you may ask? They are usually very good about these things and usually support an open standard (like they have done with XMPP, which they use for Google Chat.) My suspicion is that they want to plug their own <a title="OAuth Wikipedia page" href="http://en.wikipedia.org/wiki/OAuth">OAuth </a>instead, which is a similar protocol, but they effectively solve <a href="http://softwareas.com/oauth-openid-youre-barking-up-the-wrong-tree-if-you-think-theyre-the-same-thing">different problems</a>.

Anyway, the URL that lets you sign into OpenID enabled services is

    https://www.google.com/accounts/o8/id

This URL is the same for all Google accounts; it redirects you to Google's servers for you to confirm the logging in process. That's it.

###A good example

Stackoverflow.com is doing OpenID signing in right. I doesn't ask you to fiddle with an OpenID URL but rather gives you nice and easy logos to click on - it fills in the URL for you. Well done!

![Stackoverflow.com login page](https://lh4.googleusercontent.com/--cSZ6kT7oNg/T1uiZCGAb1I/AAAAAAAAAoo/WE6Dmn_uUEw/s698/stackoverflow-login.jpg)
