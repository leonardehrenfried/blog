---
layout: post
title: How to find out if you are running Apache mpm-prefork or mpm-worker
tags:
- apache
- Mixed
- ubuntu
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '763490393'
---
I struggled with this today whilst trying to figure out Apache's config options.

On Ubuntu you can do the following:

{% highlight bash %}
$ dpkg --get-selections |grep apache
apache2						install
apache2-mpm-prefork				install
apache2-prefork-dev				install
apache2-utils					install
apache2.2-bin					install
apache2.2-common				install
libapache2-mod-php5				install
libapache2-mod-wsgi				install
{% endhighlight %}

This tells me that I have mpm-prefork.
