---
layout: post
title: Unit testing Javascript in combination with HTML
tags:
- javascript
- testing
- html
type: post
published: true
---
_NB: Javascript is quite popular on the server-side now as well. This article
however concerns itself with JS in the browser though._

In the last 5 years Javascript has come a very long way. When I started out as 
a (browser) Javascript developer people smiled when I called myself that.
I was patronised and thought of as a lesser programmer, a pixel pusher.

Times have changed. Interactive websites are at the heart of a lot of
businesses and no longer an afterthought tacked on after the real development
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
test. This was mainly due to the fact that HTML and JS was largely separated.
The widget expected a certain kind of HTML to operate on and if this structure
wasn't there, mostly the JS widget would not work.

Activating one of these widgets often work something like this:

```javascript
$(".my-widget").datepicker("activate");
```

#### Components

But a new style of programming the DOM, fuelled by the rise of client-side MVC
frameworks like Backbone, came into being: components, views or
whatever you might want to call them. This meant that a frontend developer
wouldn't have to build a certain HTML structure and then call some jQuery plugin
on it.

Instead the HTML isn't rendered on the server but the component you are trying
to build comes with its own HTML. Instead of the above you would instead
do something like this:

```javascript
var view = new DatepickerView();
var rendered = view.render();
$(".my-widget").append(rendered);
```

Can you spot the difference here? The component itself brings its own HTML
to the table instead of manipulating some globally available DOM.

#### How is this different?

This means that each discrete component can be tested easily. If we write our
UI widgets in this style testing is rather easy.

Whilst before you were never quite sure that the HTML you produced was matching
the expectations the JS had, it is now rather easy to assert against the widget.

```javascript
rendered.find("button").click();
expect(view.clickCount).toBe(1);
```

This new-found engineering rigour means that JS code can be as easily tested
as server side code, if not easier and the difference that has enabled this
is the coupling of JS with the HTML it produces. This is the qualitative
distinction in my option.

