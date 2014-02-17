---
layout: post
title: Make Maven treat warning as errors
type: post
tags:
  - javac
  - werror
  - maven
published: false
---
I like compiler warnings and I think a nicely linted code base really improves
code hygiene and keeps standards high. Rather than relying on some post-compile
script or a tool like Sonar I prefer the compiler to throw an error when it
encouters something that we defined as a code smell. In other words, I want
it to treat warnings as errors.

`javac` can do exactly that with the `-Werror` flag. To enable it in your
Maven builds, use the following XML:

```xml
...
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.1</version>
      <configuration>
        <source>1.7</source>
        <target>1.7</target>
        <compilerArguments>
          <Werror />
          <Xlint:all />
        </compilerArguments>
      </configuration>
    </plugin>
  </plugins>
</build>
...
```

