---
layout: post
title: Using a mocked session when writing tests for Play Framework 1.2
tags:
- java
- Mixed
- mock
- play
- test
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '785915071'
---
Today I wanted to write a functional test for a Play 1.2.4 app that required the request to come with a preinitialised Play session. At first I thought that this would be easy, however it turned out that there isn't a ready-made solution for this built in so I had to cobble together the pieces myself.

Here is the method which I have put in the base class for all my FunctionalTests:
{% highlight java %}
Http.Request sessionedRequest(Map<String, Object> data) throws Throwable{
    // mostly copied from https://github.com/playframework/play/blob/master/framework/src/play/mvc/Scope.java#L255
    StringBuilder session = new StringBuilder();
    for (String key : data.keySet()) {
        session.append("\u0000");
        session.append(key);
        session.append(":");
        session.append(data.get(key));
        session.append("\u0000");
    }
    String sessionData = URLEncoder.encode(session.toString(), "utf-8");
    String sign = Crypto.sign(sessionData, Play.secretKey.getBytes());
    Http.Request req = newRequest();
    Http.Cookie cookie = new Http.Cookie();
    String cookieName = "PLAY_SESSION";
    cookie.name = cookieName;
    cookie.value = sign + "-" + sessionData;
    req.cookies = ImmutableMap.of(cookieName, cookie);
    return req;
}
{% endhighlight %}
