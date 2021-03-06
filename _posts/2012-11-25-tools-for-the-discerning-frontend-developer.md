---
layout: post
title: Tools for the discerning front end developer
tags:
- development
- tools
type: post
published: true
---

### Pro-forma preamble

Working as a web developer and doing a lot of frontend work, over the years I have collected a rather nice tool belt (if I may say so) of things that make me more productive. Today I'd like to share some of these.

### Javascript

### Grunt

![Grunt logo](https://lh6.googleusercontent.com/-rC0dC5mG4Pk/UJgVyx8ORJI/AAAAAAAAIQw/Q4M0-N92Q08/s288/logo.png)

One of my more recent discoveries is a JavaScript build tool called [grunt][5]. Even though I guess you could use it to build node modules, it is really meant for frontend coding tasks. If you've ever written your own scripts to glue together `jshint`, `uglify`, file concatenation and `rsync` and wondered if there is a better way, grunt can help you. It is ideal not only for those things but has plugins for virtually everything like:

* CoffeeScript, including on-the-fly compilation if a file is modified
* CSS Compression
* LessCSS compilation
* Live Reload of a website without browser plugins (more about this in the next section)

Yes, there is a bewildering array of JS build tools (Jake, Cake, Yeoman, Buildr, custom ant scripts... the list goes on) but I found grunt so far the most pleasurable to use. Go try it out.

### [Grunt Live Reload plugin][6]

Frankly, this is like magic. What this enables you to do is to hit save in your favourite text editor and have this automatically trigger a refresh of the page you are working on. And all of that without even installing a browser extension. The way this works is by injecting a little snippet of JavaScript into the page which in turn opens a Websocket connection to the development server which watches for changes on the file system. Here is an example `grunt.js` file to achieve this:

{% highlight javascript %}
module.exports = function (grunt) {
  grunt.initConfig({
    lint: {
      all: ['js/*.js']
    },
    less: {
      style: {
        src: 'style.less',
        dest: 'style.css'
      }
    },
    watch: {
      files: ['*.less', "*.html", "*.js"],
      tasks: 'less reload'
    },
    reload: {
      port: 6001,
      proxy: {
        host: 'localhost',
        port: 8000
      }
    },
  });
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-reload');
  grunt.registerTask('default', 'server reload watch');
};
{% endhighlight %}

Who knew that development could be fun with tools like this?

### CSS reload bookmarklet

If you don't need the whole live reload setup or are maybe using a web framework which doesn't play nice with grunt you can use Paul Irish's [CSS reload bookmarklet][7]. This simply iterates over all the stylesheets in the document and adds a fake parameter with a timestamp value to their URL causing them to be reloaded. The timestamp also takes care of any caching issues.

Chrome doesn't allow bookmarklets to be invoked with a keyboard shortcut but I found the following trick to be able to kinda-simulate a shortcut: You need to bind the bookmarklet to a custom search, which in turn can be triggered by a one-letter keyword.

![Setting a "shortcut" to a bookmarklet in Chrome by abusing a saved search](https://lh5.googleusercontent.com/-_Whl1sZppio/UJgbghpKQwI/AAAAAAAAIRA/h-aeCDdn3-w/s674/Screen%2520Shot%25202012-11-05%2520at%252021.02.27.png)

In order to do this, create a new search, paste the bookmarklet Javascript URL into the URL field, give it a name and a one letter keyword (I have given it the letter 'r'). Now you can jump to the URL bar with ⌘ + L, then type R and hit enter and voila, your CSS is reloaded without you having to refresh the entire page.

### [cdnjs][8]

This free, community-curated CDN hosts Javascript libraries like Backbone, moment.js and various popular jQuery plugins. Using this has the double advantage of not polluting your source tree with third-party libraries as well as speeding up your page load by spreading the load onto multiple servers.

An added bonus: They support SPDY for extra-parallel download for enabled browsers. You can also add a library you need to the CDN by submitting a pull request. I've done that a few times and Ryan and Thomas have always been quick and _very_ friendly.

### Twitter Bootstrap related

### [Bootswatch][1]

If you can't stand the default look of Bootstrap anymore go and check out this nice selection of themes for Bootstrap.

### [Bootstrap Form Builder][2]

![Bootstrap Form Builder](https://lh6.googleusercontent.com/-Od5fO3TehO4/UJgTx4eGJUI/AAAAAAAAIQo/Z4zslSr1aOw/s481/Screen%2520Shot%25202012-11-05%2520at%252020.29.45.png)

If you're building a lot of forms with Bootstrap, you probably want to check out this little app. It gives you a nice UI for building them.

### [Bootsnipp][3]

If it isn't forms specifically you're building, Bootsnipp gives you small snippets of readymade Bootstrap components and examples of what you could build with Bootstrap.

### [BootstrapCDN][4]

Are you tired of re-adding Bootstrap's CSS file to your repositories over and over or using Github as a static asset server? As the name suggests this free CDN hosts Bootstrap for you. My favourite feature are the hosted versions of Bootswatch.

### Misc.

### [Fontello][9]

Remember the days when you had to pester your designer for small icon PNGs (most likely in plain as well as mouseover/active variations)? Thank God we have icon fonts now! The only downside is that selecting an icon character and inserting it into your HTML is quite a bit of work and may involve special programs for font managements.

Fontello is a web app that has made it its mission to take away the pain from using icon fonts. They have collected a hand full of very popular icon fonts ([Entypo][10], for example), have given each icon character a simple, descriptive name and make this all available as single webfont file (in all formats you'll ever need) plus a handy stylesheet. This lets you create icons by simply applying a CSS class to an element, just as it is done in Twitter Bootstrap.

![Fontello](https://lh5.googleusercontent.com/-fj4HRCQhhxQ/UJgkMDywG3I/AAAAAAAAIRU/H5NWQF-UcEA/s229/Screen%2520Shot%25202012-11-05%2520at%252021.39.53.png)

If you suggest this in your team, your designer will love you as this frees her/him up to do actual design. Other benefits are that you can style your icons with CSS and have a lot less HTTP requests during page load.

### JSON formatting

[jq][11] is pretty nice tool for querying a JSON document but if all you need is a pretty printer you can pipe your JSON through a built in python module with the following one-liner:
{% highlight bash %}
echo '{"foo": "lorem", "bar": "ipsum"}' | python -mjson.tool
{% endhighlight %}
I have this aliased in my `.profile` to jsonpretty with a
{% highlight bash %}alias jsonpretty='python -mjson.tool'{% endhighlight %}

### [ack][12] - better than grep

If the project-wide full text search of `$FAVOURITE_IDE` sucks, and lets be honest they all do, and grep is just a little too awkward to use then take a look at ack. It has changed the way I explore and navigate source trees. Ack is designed to search through large source code trees, searches recursively by default and excludes stuff you definitely don't want to search like git and temp folders.

![Grepping with ack](https://lh3.googleusercontent.com/-R7dPtGgbuvQ/UJlzS4QCrlI/AAAAAAAAIRk/EnSQkgHQPy0/s471/Screen%2520Shot%25202012-11-06%2520at%252021.29.07.png)

Even though it is currently still in alpha state, I'm using version 2.0 for a couple of months now without any issues. Ack 2 removes the limitation of having to keep a whitelist of files to be searched and includes all text files by default. Another thing which wasn't possible in ack 1 but is in 2 is including file names without dots (i.e. `Gemfile`). If you want to install ack 2.0 alpha through homebrew, I have prepared a recipe for you. Just do a

    brew install https://raw.github.com/leonardehrenfried/ack2-compiled/master/ack2.rb

### Testing regular expressions
To me it was a real eye opener when I discovered visual regex tools. They
shorten the feedback loop drastically and make reasoning about them a lot
easier (even though it still often takes a few moments to fully wrap your head
around what is happening.)

My current favourite for doing that using the JS regex syntax is
an obscure tool called [Hifi Regex Tester](http://www.gethifi.com/tools/regex).
Even though its usability isn't too great (too many colours!) it is the only
one that I have found which displays match groups.

If you can live without match groups, [refiddle](http://refiddle.com/) feels a
lot more modern and tidied up.

### Your favourites

If you liked this little list, how about you letting me know about other
productivity enhancers?

 [1]: http://bootswatch.com/
 [2]: http://bootstrap-forms.heroku.com/
 [3]: http://bootsnipp.com/
 [4]: http://www.bootstrapcdn.com/
 [5]: http://gruntjs.com/
 [6]: https://github.com/webxl/grunt-reload
 [7]: http://paulirish.com/2008/how-to-iterate-quickly-when-debugging-css/
 [8]: http://cdnjs.com/
 [9]: http://fontello.com/
 [10]: http://www.entypo.com/
 [11]: http://stedolan.github.com/jq/
 [12]: http://betterthangrep.com/
