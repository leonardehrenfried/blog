---
layout: post
title: Removing 200s from an Apache access log
type: post
tags:
  - apache
  - log
published: false
---
At work we use Splunk to do log analysis of our frontend Apache which acts as
a simple proxy to the application servers. I quite like Splunk but we were
hitting our quota quite frequently when we started to include our access log
to the indexed files.

We noticed that the vast majority of our entries in the access log had `200`
response statuses. We're actually not that interested in all these 200s and
it would greatly reduce our Splunk usage if we could filter them all out.
What we could have done is to just use the normal access log and then have a
cronjob grep out all the 400s and 500s but that didn't seem very elegant. I
wanted a solution without an intermediate step.

Apache has a feature called conditional logging however it can't be used to
filter by response code.

On the other hand I found out about piped logs. The idea is that you can just
pipe the log to another process which in turn can do any log processing and
filtering you want.

I choose a combination of `grep` and Apache's `rotatelogs`. Put the following
in your Apache configuration:

```apache
LogFormat "%s %h %l %u %t \"%r\" %b" splunk
CustomLog "|stdbuf -o0 /bin/grep --invert-match '^200' | /usr/sbin/rotatelogs /var/log/apache2/splunk-access.log 86400" splunk
```

The first line defines a log format with the nickname `splunk`. In this format
we put the response code (`%s`) at the beginning of the log file so we can
grep for it easily.

The second one is where the action starts. The pipe (`|`) indicates that it is
a piped log. Next we use `stdbuf -o0` to disable `stdin` buffering which makes
it a pain to test this setup. You can skip this in production if you want to.

Next we hand over to `grep` and remove all lines that start with the string
200.

Finally we pass the data on to `rotatelogs` which rotates the log once a day
and gzippes those older than a day. Read the `rotatelogs` manual for many
more configuration settings.
