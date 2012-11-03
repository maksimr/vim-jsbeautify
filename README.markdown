vim-jsbeautify - v1.0.0 - 2012-08-15
---------------------------------------------------
[![Build Status](https://secure.travis-ci.org/maksimr/vim-jsbeautify.png)](http://travis-ci.org/maksimr/vim-jsbeautify)

Description
------------

This extension allows you to use the [jsbeautifier] (http://jsbeautifier.org/)
inside vim-and that will allow you to quickly format javascript, html and css files.
And with version 1.0 has support [editorconfig] (http://editorconfig.org/) file.

Any comments, corrections and suggestions are welcome.

Installation
------------

### Dependencies
To use this extension you need
will install one of the javascript interpreter
[nodejs] (http://nodejs.org/) or [v8] (http://code.google.com/p/v8/).

### Installing using pathogen

```bash

  cd ~/.vim/bundle
  git clone https://github.com/maksimr/vim-jsbeautify.git
  cd vim-jsbeautify && git submodule update --init --recursive

```

### Installing using vundle

Simply add a line to your .vimrc.

```vim

  Bundle 'maksimr/vim-jsbeautify'

```
Also need to be installed after the expansion, go to its folder
and perform ```git submodule update - init - recursive ``` or specify
when you set up the path to the external file format (shown below).

Setting
-------------

In version 1.0, all configuration is done through a file. Editorconfig.
This file can be located either in the root folder for the user `` `~ /. Editorconfig ```,
or in a folder. vim `` `~ / .vim / .editorconfig ```.

Settings are taken from sections [\*\*. js], [\*\*. css] and [\*\*. html]. within these
sections can use a special comment ```; vim: ```, but this comment
can be used only for the global settings.

You can also configure a variable ```g: config_Beautifier ```, but it is better to use. Editorconfig file.


### Examples

```editorconfig
  ".editorconfig

  root = true

  [**.js]
  indent_style = space
  indent_size = 4

  [**.css]
  indent_style = space
  indent_size = 4

  [**.html]
  indent_style = space
  indent_size = 4
  max_char = 78
  brace_style = expand

```

```editorconfig
  ".editorconfig

  root = true

  [**.js]
  ; Path to the external file format
  ; The default is taken from the lib folder inside the folder extension.
  path=~/.vim/bundle/js-beautify/beautify.js
  ; Javascript interpreter to be invoked by default 'node'
  bin=node
  indent_style = space
  indent_size = 4

  [**.css]
  path=~/.vim/bundle/js-beautify/beautify-css.js
  indent_style = space
  indent_size = 4

  [**.html]
  ; Using special comments
  ; And such comments or apply only in global configuration
  ; So it's best to avoid them
  ;vim:path=~/.vim/bundle/js-beautify/beautify-html.js
  ;vim:max_char=78:brace_style=expand
  indent_style = space
  indent_size = 4

```

Usage
-------------

```vim
  ".vimrc

  map <c-f> :call JsBeautify()<cr>
  " or
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  " for html
  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " for css or scss
  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

```

JsBeautify function takes two parameters, this number of start and end lines.
Default is 0 and '$'.


[Website](http://github.com/)

Copyright (c) 2012 Maksim Ryzhikov; Licensed MIT
