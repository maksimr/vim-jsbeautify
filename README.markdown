vim-jsbeautify - v1.1.0 - 2012-12-27
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
This file can be located either in the root folder for the user ```~ /. editorconfig ```,
or in a folder. vim ```~ / .vim / .editorconfig ```.

Settings are taken from sections [\*\*. js], [\*\*. css] and [\*\*. html]. within these
sections can use a special comment ```; vim: ```, but this comment
can be used only for the global settings.

You can also configure a variable ```g: config_Beautifier ```, but it is better to use. Editorconfig file.


### Examples

A simple example of .editorconfig file:

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

.editorconfig file which use special comments (```;vim:```)
and special properties for jsbeautify plugin like ```path```, ```bin```

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

JsBeautify function takes two parameters, this number of start and end lines by
default they are stet to 0 and '$'.

## Running tests
Tests are written in [Urchin](http://www.urchin.sh) for vim files and build in [Grunt](https://github.com/gruntjs/grunt) test runer for javascript files.
Install Urchin like so.

    wget -O /usr/local/bin https://raw.github.com/scraperwiki/urchin/0c6837cfbdd0963903bf0463b05160c2aecc22ef/urchin
    chmod +x /usr/local/bin/urchin

(Or put it some other place in your PATH.)

There are vim tests and javascript tests.
The vim tests are written in Urchin.

    urchin test/vim

    or

    grunt urchin

To start javascript tests run:

    grunt test

For run all tests simple type:

    grunt

All commands you should run from plugin directory.

Thanks for assistance:

+ [@stonelee](https://github.com/stonelee)
+ [@peterfoldi](https://github.com/peterfoldi)

## License

Licensed MIT
Copyright (c) 2012 Maksim Ryzhikov;
