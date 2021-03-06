---
layout: post
title: How to deactivate one macport variant and switch to another one
tags:
- macports
- Mixed
- os x
- port
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '756516064'
---
Lets say for instance you have installed PHP with MySQL support with macports:

    sudo port install php5 +mysql5

But later on you decide you want to use SQLite, too, you'll have to rebuild PHP with SQLite extensions, like this.

    sudo port install php5 +mysql5 +sqlite

Now you have to deactivate the MySQL-only build and activate the one with SQLite bindings. I couldn't find it anywhere in in the macports manual so here it goes.

Get a list of your current PHP5 builds with

    $ sudo port activate php5
    Password:
    --->  The following versions of php5 are currently installed:
    --->  php5 @5.2.8_1+apache2+macosx
    --->  php5 @5.2.8_1+apache2+macosx+mysql5 (active)
    --->  php5 @5.2.8_1+apache2+macosx+mysql5+sqlite
    Error: port activate failed: Registry error: Please specify the full version as recorded in the port registry.

Then copy and paste the currently activated port and use the deactivate command.

    sudo port deactivate php5 @5.2.8_1+apache2+macosx+mysql5
    -->  Deactivating php5 @5.2.8_1+apache2+macosx+mysql5

Then copy and paste the one you would like to use and use the activate command:

    sudo port activate php5 @5.2.8_1+apache2+macosx+mysql5+sqlite
    -->  Activating php5 @5.2.8_1+apache2+macosx+mysql5+sqlite

That's it.
