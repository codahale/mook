# Mook

Mook is a simple static site generator.

## Getting Started

    gem install mook

And you're off.


## Site Layout

```
+ my-site
  + pages
    - index.md
    - about.md
    - contact.md
  + static
    + css
      - mypage.css
  + templates
    - _toolbar.erb
    - default.html.erb
```

Pages go in a directory called `pages`, static content goes in a directory called `static`, templates go in `templates`.


## Pages

[blah](#bloo)

A page is a Markdown document with some leading metadata:

    Title: About Me
    Template: default.html.erb
    Order: 2
    * * *
    
    I'm just a simple country [hyperchicken](#more).
    
    Here's some Ruby code:
    
    ``` ruby
    Poop.new(:yay => "whee")
    ```
    
    ## Perhaps Some More Stuff. #more
    
    Also, some other stuff.

A few things of note:

* `Title` and `Template` are mandatory, `Order` is optional.
* Fenced (i.e., ` ``` `-surrounded) code blocks are OK, and if you add the 
  language name, Mook will syntax highlight the code for you.
* Adding a name to a header (i.e., `#more`) created a named anchor above that
  header with that name so's you can link to it.
* Strike-through (`~struckthrough~`) is supported.
* Superscript (`2^128` or `this is the 2^(nd) time`) is supported.
* URLs are automatically linkified.
* Smart quotes, dashes, ellipses, etc. are all supported.


## Templates

Templates are ERB templates. They've got all the usual features, plus the
following stuff in scope:

* `site`, which wraps the idea of the site you're generating. Has a `#pages`
  method, which returns an array of all the pages in the site.
* `page`, which wraps the idea of the current page being rendered. Has the
  following methods:
  * `#name`: the page's name, as defined by the filename
  * `#title`: the page's title
  * `#content`: the page's Markdown content, rendered as HTML
  * `#toc`: a nested `<ul>` list of all the page's headers, with links


## Running

Run this:

    mook

Then look in the `target` directory for an awesome surprise.


## But this doesn't do what I want

Sorry.

## Licensing

Copyright 2011 Coda Hale. Licensed to you under the MIT license. Don't screw
this up for anyone.