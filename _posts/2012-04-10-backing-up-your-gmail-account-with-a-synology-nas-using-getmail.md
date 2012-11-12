---
layout: post
title: Backing up your Gmail account with a Synology NAS using getmail
tags:
- getmail
- gmail
- imap
- Mixed
- synology
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '756516534'
  _wp_old_slug: backing-up-your-gmail-account-with-on-a-synology-nas-using-getmail
---
Recently, I had a bit of a data loss scare where I couldn't access my Google Account for a few hours. In the end it turned out to be a well-meaning Google protection mechanism that kicked in because I tried to access my account while on holiday on the Canary Islands. I have heard horror stories of people loosing their email histories stored in Gmail and this little incident got me scared enough to investigate backing up my email history outside of Gmail.

I use a Synology NAS at home which has plenty of storage left to keep my roughly 2GB of email many times over. It has a variant of Linux installed and besides a nice web-based UI it has also the very handy ability to ssh into the box and install additional software through a package manager called ipkg.

###The setup<
Login to your NAS as root and install getmail with these commands:

{% highlight bash %}ipkg update
ipkg install python
ipkg install py25-getmail
{% endhighlight %}

Now that your have the software in place pick a place where the email should be stored. I chose <code>/volume1/Gmail</code> but any folder that is accessible to your ordinary user will do. Still logged in as root issue these commands:

{% highlight bash %}
mkdir /volume1/Gmail
cd /volume1/Gmail
mkdir cur new tmp
{% endhighlight %}

The last one is necessary for the storage format (Maildir) and getmail doesn't create these folders itself. Maildir stores each email in a separate file on the disk. If you want another storage format, read the getmail documentation.

Then create a file called <code>/volume1/Gmail/getmailrc</code> with the following content, using your own username and password:

{% highlight ini %}[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
mailboxes = ("[Gmail]/All Mail",)
# if you have a German account, use [Google Mail] like this
# mailboxes = ("[Google Mail]/All Mail",)
username = USERNAME@gmail.com
password = USERPASS

[destination]
# save each email in a separate file
type = Maildir
path = /volume1/Gmail/

[options]
verbose = 2
message_log = /volume1/Gmail/log

# retrieve only new messages
# if set to true it will re-download ALL messages every time!
read_all = false

# do not alter messages
delivered_to = false
received = false{% endhighlight %}
Now everything is in place for getmail to do its work. Do a test run with the following command to test if it will run into any problems.
{%highlight bash%}getmail --getmaildir=/volume1/Gmail{%endhighlight%}
This will start downloading your messages but depending on the size of your email history will take up to a few hours. There is the distinct probability that your ssh connection will time out and drop due to your inactivity. That's why I ran the first go with nohup so that me logging out wouldn't stop the process.
{% highlight bash %}nohup getmail -q --getmaildir=/volume1/Gmail & > /volume1/Gmail/nohup.out{% endhighlight %}

###Cron

Lastly, we obviously want to run getmail periodically and fetch the newest message so open up <code>/etc/crontab</code> with a text editor like vim (you probably need to install it with ipgk first) and add the following line:
{% highlight bash %}0       3       *       *       3       root    /bin/su -c "/opt/bin/getmail -q --getmaildir=/volume1/Gmail" admin{% endhighlight %}
(It is important so separate the individual parts of the crontab with a tab not a space as otherwise the Synology will delete your entry when you reboot.)

This will run getmail every Wednesday at 3AM when you're sound asleep. The <code>/bin/su</code> complication is necessary because it appears that the Synology cron can't run jobs as non-root.

Also, on my Synology you have to restart the cron daemon for it to pick up the changes with a

{% highlight bash %}synoservice --restart crond{% endhighlight %}
