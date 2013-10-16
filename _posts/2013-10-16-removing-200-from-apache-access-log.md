---
layout: post
title: Removing 200s from an Apache access log
type: post
tags:
  - apache
  - log
published: true
---
At work we use Splunk to do our log analyis of our frontend Apache which simpy
proxies to the application servers. I quite like Splunk but we were
hitting our quota quite frequently when we started to include our access log
to the indexed files.

We noticed that the vast majority of our entries in the access log had `200`
response statuses. We're actually not that interested in all these 200s and
it would greatly reduce our Splunk usage if we could filter them all out.
What we could have done is to just use the normal access log and then have a
cronjob grep out all the 400s and 500s but that didn't seem very elegant.

Apache has a feature called conditional logging, however, it can't be used to
filter by response code.

On the other hand I found out about piped logs. The idea is that you can just
pipe the log to another process which in turn can do any log processing and
filtering you want.

I choose the following combination of `grep` and Apache's `rotatelogs`.

```
LogFormat "%s %h %l %u %t \"%r\" %b" splunk
CustomLog "|stdbuf -o0 /bin/grep --invert-match '^200' | /usr/sbin/rotatelogs /data/home/lehrenfried/splunk-access.log 86400" splunk
```
