---
layout: post
title: Find out who the maintainer of a Debian/Ubuntu package is
type: post
tags:
  - javac
  - werror
  - maven
published: false
---
Run the following command:

```xml
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

```

