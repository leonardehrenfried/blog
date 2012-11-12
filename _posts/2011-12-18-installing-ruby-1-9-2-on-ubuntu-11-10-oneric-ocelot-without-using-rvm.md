---
layout: post
title: Installing Ruby 1.9.2 on Ubuntu 11.10 Oneiric Ocelot without using RVM
tags:
- Mixed
- ruby
- ubuntu
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _wp_old_slug: installing-ruby-1-9-2-on-ubuntu-11-10-oneric-ocelotwithout-using-rvm
  dsq_thread_id: '756516507'
---
It seems installing Ruby 1.9 on Ubuntu without the use of RVM isn’t all that trivial. I had to poke around the system for quite a while before I got it running.
###Why not RVM?
Well, I tried RVM but compiling Ruby <strong>took 3 hours</strong> on my EC2 micro instance and was eating all my CPU so that my webserver was basically not available anymore. To me that isn't acceptable. Besides, I think it is highly wasteful to compile packages from source when there are precompiled versions available. I admit that apt is too slow to keep up with the rapidly moving gems ecosystem but for the Ruby interpreter itself I strongly prefer the OS to handle the installation.

Besides I don't really want to use different versions of Ruby at the same time. I just want something that isn't Ubuntu's default 1.8.7, which in Ruby years is ancient.

###The steps
The good news is that as of writing this, Ruby 1.9.2 is available without any PPAs straight from the official Canonical package repos. The bad news is that information about how to get it is thin on the ground.

For starters the package for Ruby 1.9.2 is called ruby1.9.1 and Googling around, it wasn't immediately obvious that any version of Ruby 1.9 is even possible on Ubuntu.

Anyway, here it goes:

{% highlight bash %}sudo apt-get update

sudo apt-get install ruby1.9.1 ruby1.9.1-dev \
  rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
  build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
         --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
                        /usr/share/man/man1/ruby1.9.1.1.gz \
        --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
        --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
        --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

# choose your interpreter
# changes symlinks for /usr/bin/ruby , /usr/bin/gem
# /usr/bin/irb, /usr/bin/ri and man (1) ruby
sudo update-alternatives --config ruby
sudo update-alternatives --config gem

# now try
ruby --version{% endhighlight %}
This installs Ruby 1.9.2 and sets that to be the default ruby on your system. Crucially, it also installs rubygems for that interpreter and sets that to be the default. (Thanks for the initial snippet to <a href="http://michalf.me/blog:make-ruby-1-9-default-on-ubuntu-9-10-karmic-koala">Michał Frąckowiak</a>. His version got me most of the way there.)
###Uninstalling Ruby 1.8
If you, like me, ran a Rails app on 1.8 you probably have a bit of stuff hanging around the file system. Lets clean that up.

First uninstall all gems from the 1.8 installation with:
{% highlight bash %}gem1.8 list | cut -d" " -f1 | xargs sudo gem1.8 uninstall -aIx{% endhighlight %}

Secondly, remove the ruby packages with apt.

{% highlight bash %}sudo apt-get remove libruby1.8 ruby1.8 ruby1.8-dev rubygems1.8{% endhighlight %}
After you have done that you may want to check if there is anything else hanging around with a quick:
{% highlight bash %}dpkg --get-selections |grep ruby{% endhighlight %}
