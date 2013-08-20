---
layout: post
title: Unit testing Javascript UIs
tags:
- javascript
- testing
- html
type: post
published: true
---
_NB: Javascript is quite popular on the server-side now as well. This article
however concerns itself exclusively with JS in the browser._

In the last 5 years Javascript has come a very long way. When I started out as
a (browser) Javascript developer people smiled when I called myself that.
I was patronised and thought of as a lesser programmer, a pixel pusher. To be
fair there was some truth to it as widgets often broke.

Times have changed. Interactive websites are at the heart of a lot of
businesses and no longer an afterthought tacked on after the "real" development
has been completed.

But still, there is a large holdout who think of browser programming with
Javascript as a foolish activity and not a serious developer's job.

Today, I chatted to a friend about this and have started to develop at theory
why that might be. I think it has partially something to do with how Javascript
testing was done in the browser.

#### JS and HTML

On traditional web apps it worked mostly like this:

- The server spits out HTML which is the baseline and users should be able to
use the app/website even whith JS disabled
- Javascript then takes the exitisting HTML and applies some transformation on
it, rendering it more interactive.

This meant that the widgets the frontend developers built were really hard to
test, due to the fact that HTML were JS was largely separated.
The widget expected a certain kind of HTML to operate on and if this structure
wasn't there, mostly the JS widget would just not work.

Activating one of these widgets often work something like this

```javascript
$(".my-widget").datepicker("activate");
```

and this would assume a DOM structure which would look something like this

```html
<div class="my-widget">
  <input type="text">
  <div class="dropdown"></div>
</div>
```

#### Components

But a new style of programming the DOM, fuelled by the rise of client-side MVC
frameworks like Backbone, came into being: the UI became parcelled up into
components, views or whatever you might want to call them.
This meant that a frontend developer wouldn't have to build a certain
HTML structure and then call some jQuery plugin on it.

Instead, the HTML isn't rendered on the server but the component you are trying
to build comes with its own HTML. Rather than the above you would do something 
like this:

```javascript
var view = new DatepickerView();
var rendered = view.render();
$(".my-widget").append(rendered);
```

Can you spot the difference here? The component itself brings its own HTML
to the table instead of manipulating some globally available DOM.

#### How is this different?

If we write our UI widgets in this style testing is rather easy. Before, if
you wanted to really test your JS you had to test both the HTML the server
produced _as well_ as the widget code that operated on it. That would mean to
somehow also build up the entire context of the server-side templating
language and render a full response.

Whilst before you were never quite sure that the HTML you produced was matching
the expectations the JS had, it is now rather easy to assert against the widget.

```javascript
rendered.find("button").click();
expect(view.clickCount).toBe(1);
```

This new-found engineering rigour means that JS code can be as easily tested
as server side code, if not easier and this difference that has made is
the coupling of JS with the HTML it operates on (and produces).
In my option, that's the qualitative distinction.

In fact, if all your server produces is JSON, testing asserting against that
becomes easy too. You no longer have to do some DOM gymnastics to find out
if your the server has generated the correct response: just parse the JSON
and assert against that.

#### Conclusion

Nowadays, JS-heavy projects are thought of as API clients to the server that
produces JSON. This has enabled a style of frontend development that takes
raw data as its input and not data mixed with a sprinkling of presentation
layer. I think that this is a good thing. Frontend developers are now
writing programs, apps and no longer just spice up your `<select>` elements.
