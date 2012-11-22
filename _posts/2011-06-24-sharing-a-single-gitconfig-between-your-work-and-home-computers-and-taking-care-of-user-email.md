---
layout: post
title: Sharing a single gitconfig between your work and home computers and taking
  care of user.email
tags:
- bash
- git
- Mixed
- sharing
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '759069976'
---
I just started a new job where git is being used and since I had accumulated some stuff in mit `.gitconfig`, I wanted it to be on my work computer too. I use a git repository for all my dotfiles, which I then clone on the machine and symlink files like `.gitconfig` or `.vimrc` to the home directory. This means if I add something to those files at work and want to use the configuration at home too I just need to commit, push and pull the changes at home. Well, this works pretty good until you realise that there are *some* config entries you want to be different in the two environments. Git's `user.email` is obviously such a case.

### The solution

Git does not allow you to to include other configuration files in your `.gitconfig` but you can use the environment variable `$EMAIL` in order to overwrite `user.email`. What I have done is to add the following to my `.bashrc` (which is also in the dotfiles repo):

{% highlight bash %}
if [ -f .host-specific.sh ] then
  source .host-specific.sh
fi
{% endhighlight %}

This loads a host-specific bash file (if it exists). In this file you'll stick your email address like this:

    export EMAIL=lenni@work.com

(Obviously this file needs to be recreated on each host and can't be shared across computers through the dotfile repository.) Now you can safely share your `.gitconfig` between the two computers without having to worry about the email settings.

