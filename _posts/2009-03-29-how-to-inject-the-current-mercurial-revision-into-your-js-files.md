---
layout: post
title: How to "inject" the current mercurial revision into your JS load requests
tags:
- bash
- grep
- mercurial
- Mixed
- regex
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '756516112'
---
When you do web development you will soon have to find a way to force users to download a new version of your JavaScript files before their browser cache actually requires it. The best way to do this is just add a made-up GET argument to the file name when you load the script and change this when you upload an new version of the script.
It should look something like this:

```html
<script src="behaviour.js?revision=14" type="text/javascript"></script>
```
One of my JavaScript "build scripts" has this one automated and reads the current revision from my mercurial repository of this project. In order to just get the revision number type this in the console when you are cd'ed into the project folder (I recognised that this is not the most elegant of bash scripting, but it will do the job):

```bash
hg log -l1|grep changeset|grep -o  "\([0-9]\+\):"|grep -o "\([0-9]\+\)"
```

In your HTML files you will need a little placeholder that will mark all those places where the current revision number should be injected. I chose the string <code>{REV}</code>. Your HTML header should look like this:

```html
<script src="behaviour.js?revision={REV}" type="text/javascript"></script>
```

Now, the next step replaces all occurrences of the string <code>{REV}</code> with the number of the current mercurial revision. The following script takes one argument: the filename (or file pattern) that should be scanned for the string <code>{REV}</code>.

```bash
#!/bin/bash
export rev=`hg log -l1|grep changeset|grep -o  "\([0-9]\+\):"|grep -o "\([0-9]\+\)"`
echo "Replacing all occurences of {REV} in $1 with the current hg revision "$rev
perl -pi -e 's/{REV}/'$rev'/g' $1
```

So put this code in a file, say, replace.sh, make it executable and then run it with something like

```bash
./replace.sh index.html
```
