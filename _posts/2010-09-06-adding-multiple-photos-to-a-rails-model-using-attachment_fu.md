---
layout: post
title: Adding multiple photos to a Rails model using attachment_fu
tags:
- attachments
- Mixed
- rails
status: publish
type: post
published: true
meta:
  _wp_old_slug: ''
  _edit_last: '1'
  dsq_thread_id: '759862891'
---
### Useless preamble

This weekend I finished off my own little [Hello World mini-CMS][1], that I wrote in order to learn Ruby on Rails. The last part meant adding an image uploader, that would allow users attach an image to a page. There are two popular image uploader plugins for Rails: The slightly older, more complicated and feature-rich [attachment_fu][2] and the more nimble [paperclip][3]. Paperclip seems to have the limitation that it only allows one attachment per model instance. On the other hand, you don't need to create a separate model for your attachments. For this project I absolutely needed multiple attachment per page so I went with attachment\_fu. I also didn't want a separate form for uploading images, which would mean having to later associated the image with a page - I wanted to be able to upload from the page's editing form. This case doesn't seem to be covered well in attachment\_fu's documentation, so this is an attempt of closing this gap.
### Installing the requirements

You will have to install an image processor. This is described in many other [blog posts][4] so I won't regurgitate it here. I personally went with ImageMagick and rmagick. Seems to work fine. Once you've done that you obviously have to install the plugin itself with:
    ./script/plugin install http://github.com/technoweenie/attachment_fu.git

**Edit:** Rails 3 has been released shortly after I wrote this post and this plugin doesn't work anymore. However there is an alternative branch on Github.

### Setting up the models

You will need to use a separate model to store all the attachment meta data. I have called mine Photo but that name is arbitrary - call it what you want. So, lets build a migration:

{% highlight ruby %}
class AddPhotos > ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :parent_id,  :integer
      t.column :content_type, :string
      t.column :filename, :string
      t.column :thumbnail, :string
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
      t.column :article_id, :integer
    end
  end

  def self.down
    drop_table :photos
  end
end
{% endhighlight %}

### Controller & form

A lot of tutorials say that you should set up your own controller for the image upload. But that would mean that you have to use a separate form for uploading images. What I wanted to do was to also use the ordinary page editing form for image uploads. So, I found a [forum post][5] that put me on the right track and after a bit more of trial and error I figured it out. First, you need to slightly edit the form where you want to upload the image from. It needs to be a multipart form and you need to add a file field. With the `file_field_tag` part you are telling Rails that it should not put the photo attachment in the main form object but rather create a second hash called `photo`. In the controller we will be reading out exactly this hash and store it in the photo model. So, here is the controller code:

{% highlight ruby %}
class ArticlesController < ApplicationController
  def update     @article = Article.find(params[:id])
   respond_to do |format|
     if @article.update_attributes(params[:article])
     if params[:photo]
       puts "Photo found"
       # read out the POSTDATA hash 'photo' and try to create a photo
       # also associate it with the article
       @article.photos.create!(:uploaded_data=>params[:photo]) #if image.size != 0
           end
          format.html { redirect_to(@article, :notice => 'Article was successfully updated. [PUT]') }
          format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
end
{% endhighlight %}

I couldn't find a good tutorial on how this is done so I hope someone wanting to do the same will find this page. Happy coding.

 [1]: https://lenni.info/blog/2010/07/thoughts-about-rails-from-a-django-guy/
 [2]: http://github.com/technoweenie/attachment_fu
 [3]: http://github.com/thoughtbot/paperclip
 [4]: http://significantbits.wordpress.com/2007/04/06/using-attachment_fu-by-techno-weenie-to-add-image-attachment-support-to-your-rails-application/
 [5]: http://www.ruby-forum.com/topic/164189
