---
layout: post
title: Starting WEBBrick with logging disabled
tags:
- ruby
- webbrick
type: post
published: true
---

Today I had to start a little web server that prints out the HTTP requests
received and I used Ruby's WEBBrick for that.

The trouble is that it has its own logging built in that interfered with what
I was trying to log.

Here is how you disable logging completely:

```ruby
dev_null = WEBrick::Log::new("/dev/null", 7)
server = WEBrick::HTTPServer.new({ :Port => 9000, :Logger => dev_null, :AccessLog => dev_null })
server.start
```

