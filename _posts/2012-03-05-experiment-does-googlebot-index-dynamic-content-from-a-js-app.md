---
layout: post
title: ! 'Experiment: Does Googlebot index dynamic content from a JS app?'
tags:
- googlebot
- html5
- javascript
- Mixed
- seo
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '756516529'
---
I've started a new job and we are evaluating whether we would still like to use a server-side framework for HTML generation or whether we should go for a client-side DOM manipulation/JS-templates-only-approach where the browser calls into the API directly.

One of the drawbacks of the latter is that the conventional wisdom not so long ago was that Googlebot would not execute any JavaScript and hence the content would be invisible to it. However, some people started to notice that Facebook comments, which are created dynamically on the fly by a JS widget, are being indexed by Google. This was confirmed by Matt Cutts in a [tweet][1]. There is also an [official blog post][2] by Google about this topic but both are pretty sparse on any details. There is a certain amount of [speculation floating around][3] that Googlebot could in reality be some modified version of Chrome.

### The experiment

Therefore I have decided to put up a [small Backbone demo page][4] with the opening lines of Richard III. - this is sure to be a pretty unique string that won't show up anywhere else on my website. The actual content is being pulled in by an Ajax call and then inserted into the DOM. Using jQuery, underscore and Backbone is of course overkill for such a small site but I wanted to simulate realistic conditions.

I'm going to wait a few days and then update this blog post. In the meanwhile you can keep checking the [unique search query for the dynamic content][5] and see if something shows up over the next few days. The page has some content already present in the HTML (the Macbeth part) which will help comparing the Google results. You should be able to find that part on Google with a another [specially crafted search query][6].

### Edit 15/03/12: The results

Well, that was a bit of an anti-climax. I've been waiting for 10 days now and Google didn't index [the dynamic content][5] at all! The [static content][6] is in their index so that means that it managed to crawl the page successfully. This obviously has repercussions for people wanting to write indexable JavaScript apps. To be honest I'm a little deflated that this didn't work. I didn't expect Google to randomly click on buttons in the app but I thought they would at least run the initial JavaScript and then add the content of the DOM into their index. Does anybody know more?

 [1]: https://twitter.com/#!/mattcutts/status/131425949597179904 "Matt Cutts tweet about Googlebot and AJAX"
 [2]: http://googlewebmastercentral.blogspot.com/2011/11/get-post-and-safely-surfacing-more-of.html
 [3]: http://news.ycombinator.com/item?id=3182579
 [4]: http://lenni.info/backbone-googlebot-test/
 [5]: https://www.google.com/search?q=site:lenni.info%20%22Now%20is%20the%20winter%20of%20our%20discontent%20Made%20glorious%20summer%20by%20this%20sun%20of%20York%22
 [6]: https://www.google.com/search?q=site:lenni.info%20%22Thunder%20and%20lightning.%20Enter%20three%20Witches%22
