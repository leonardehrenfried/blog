---
layout: post
title: List all your Github pull requests with a jQuery widget
tags:
- github
- jquery
- Mixed
- pull request
- widget
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '841144295'
---
I, like a lot of developers, love Github. I treat my account a bit like a business card for myself and brochure for what I can do. Whenever the time rolls around to look for a new job, having a few interesting project in there helps a lot during and after the interview.

The problem however is, that some of the work I do is in pull requests to other projects. After my pull request is either accepted or rejected I usually delete my fork of the project because I want my project list to be clean and free of stuff of which I am merely a small time contributor. There is no way on the Github website itself to list a user's past pull requests.

So, in order to show off the pull requests I have done, I coded up a little widget (needs jQuery) which pulls the information out of the API and displays it. So, without much further ado, here it is.

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://lenni.info/pull-request-widget/pull-request-widget.js"></script>
<link rel="stylesheet" href="http://lenni.info/pull-request-widget/pull-request-widget.css"/>

<div id="pull-requests" data-github-user="lenniboy"></div>

<script type="text/javascript">
jQuery(document).ready(function(){
  jQuery("#pull-requests").pullRequests();
});
</script>


If you want to know how to use it yourself, check out the "[marketing website](http://lenni.info/pull-request-widget)", which has instructions about adding it to your website.
