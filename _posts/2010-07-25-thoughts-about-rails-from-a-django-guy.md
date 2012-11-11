---
layout: post
title: Thoughts about Rails from a Django guy
tags:
- Mixed
status: publish
type: post
published: true
meta:
  _wp_old_slug: ''
  _edit_last: '1'
  dsq_thread_id: '756516265'
---
My first and still my favourite programming language is Python and Django has so far been my framework of choice for my personal projects. Nevertheless, when a good friend of mine scrounged a free website off me a little while ago, I didn’t do what I normally do when friends ask for freebies: setting up another instance of Wordpress on my server and let them choose a free template. Instead I decided to write my own CMS for his website using Rails.

I had read and heard lots of praise about Rails and was planning to add another skill to my list. I thought to myself that if I’m doing him a favour he can put with the slow speed of a developer  learning a new language and framework.

Whilst working through the documentation and tutorials I couldn’t help comparing Rails to Django, since it is the framework I’m most comfortable with and it takes a little time to unwire your assumptions and expectations of how a web framework ought to work. So, basically this is a one-sided mini-review of Rails.

###The Ruby language

I didn't know any Ruby before this project but everybody knows these days, that the blogging engine is the new 'Hello World'. Ruby and Python are more alike than they’re different. Both are interpreted, use duck typing and both impose little structure on the source files. Ruby is slightly less readable to me due to the following things

 - too many <a href="http://en.wikipedia.org/wiki/Sigil_(computer_programming)">sigils</a>
 - multiple possible function/method calling syntaxes
 - the block syntax - it took me a little while to get used to but I've grown rather fond of it

I've read that Ruby lacks the amount of non-web libraries that Python has. But that doesn't bother me since I almost exclusively do web stuff. I'm simply not clever enough to have a use for for SciPy and NumPy.

###What I don't like about Rails

####ActiveRecord

The abovementioned project obviously didn't need a really complicated data model: a handful of entities with some simple many-to-ones. Particularly because ActiveRecored markets itself as a simpler solution to heavyweight enterprise ORMs like Hibernate, I found setting up this schema surprisingly difficult. Compared to Django, Rails introduces a few new concepts, which took me little bit to get my head around it.

  - <strong>separation of schema and model:</strong> in Django the model <em>is</em> the schema and I couldn't really understand why those two things should be separate
  - <strong>migrations:</strong> I can see how this could come in handy but in my case this was yet another extra thing I had to keep tabs of
  - if you have a <strong>many-to-many relationship</strong> you will have to define a join table yourself; in my view this is exactly the type of thing that an ORM at the abstraction level of ActiveRecord should take care of

Particularly due to that last point I kept thinking that ActiveRecord is just SQL rewritten in Ruby.

###Templating

Using pure Ruby in .erb templates surely is powerful but to me smells of Java Scriptlet, doesn't it? I subscribe to the view that the template language is for designers and should only allow safe constructs. Not really a biggie, but rather a little quirk.
###No built-in admin
This is something I love about Django and find kind of a deal-breaker with Rails. Django gives you great looking admin interfaces for editing your data out of the box. It takes you 95% of where you want your admin area to be and I myself never had the need to customize the template. I hear that with the introduction of the newforms library it is now not so hard anymore to write your own admin views. All in all, I'm pretty surprised that Rails hasn't even got anything remotely similar. (Maybe I have given up looking too soon? Let me know in the comments.)

###What I like about Rails
####Directory structure
Rails is pretty good at giving you a feeling of where your files ought to be in the directory structure, by neatly giving you a controller per model. Also, I quite like the distinction between the top level folders <code>config</code>, <code>app</code>, <code>db</code>, <code>test</code> etc. This is, in my opinion, something of a weak point in Django, where I never quite understood where stuff is supposed to live. Yes, you say that you should be separating your code into individual Django apps but I think that is the wrong abstraction level and like the concepts of plugins somehow better. That might be the Java developer in me speaking - a gem is much more like a JAR.

###Dependency management

It's great that you can specify the needed gems for your application and even tell the runtime that you need a specific version of Rails. I haven't tried it but it seems that the needed gems are automatically installed if they aren't already. Managing your dependencies is kinda non-existent in Django.

###Grass isn't always greener

Well, I don't really know what I expected but Rails does not magically solve all problems and does not trivialise web development. On the other hand I wasn't unhappy with Django - I just wanted to expand my horizon.

Rails certainly boosts your productivity but I found a few things, mostly around ActiveRecord, a bit strange and counterintuitive. I can't say that I have fallen in love with Rails but it is a solid framework worth its popularity. Bear in mind that this is me speaking after using Rails for about 2 weeks - I'm sure I have only scratched the surface of the things that Rails can do for me; I hear that the testing and deployment tools are fantastic. Maybe I'll do a follow up post on how my view changed after I used them.
