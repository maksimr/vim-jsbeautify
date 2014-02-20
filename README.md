vim-jsbeautify - v1.1.1 - 2012-12-27
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

### Installing without plugin-manager

Download zip [file] (https://github.com/maksimr/vim-jsbeautify/archive/master.zip)
or clone project. Then copy `plugin` folder from plugin's directory to your `dot vim (.vim)` folder.

``` bash

unzip master.zip
cd vim-jsbeautify-master
cp -r plugin ~/.vim/

```

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

You'd better add another line in your .vimrc to use js-beautify.

```vim

    Bundle 'einars/js-beautify'
    
```

call BundleInstall()

```vim

    :BundleInstall

```

Also need to be installed after the expansion, go to its folder
and perform `git submodule update --init --recursive` or specify
when you set up the path to the external file format (shown below).

Setting
-------------

In version 1.0, all configuration is done through a file `.editorconfig`.
This file can be located either in the root folder for the user `~ / .editorconfig `,
or in a folder. vim `~ / .vim / .editorconfig `.

To define custom path to .editorconfig file you should define variable `g:editorconfig_Beautifier`

Settings are taken from sections [\*\*. js], [\*\*. css] and [\*\*. html]. within these
sections can use a special comment `; vim:`, but this comment
can be used only for the global settings.

You can also configure a variable ```g: config_Beautifier```(g:config_Beautifier has type **dict**), but it is better to use. Editorconfig file.


### Examples

A simple example of .editorconfig file:

```ini
  ; .editorconfig

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


```ini
  ; .editorconfig

  root = true

  [**.js]
  ; Path to the external file format
  ; The default is taken from the lib folder inside the folder extension.
  path=~/.vim/bundle/js-beautify/js/lib/beautify.js
  ; Javascript interpreter to be invoked by default 'node'
  bin=node
  indent_style = space
  indent_size = 4

  [**.css]
  path=~/.vim/bundle/js-beautify/js/lib/beautify-css.js
  indent_style = space
  indent_size = 4

  [**.html]
  ; Using special comments
  ; And such comments or apply only in global configuration
  ; So it's best to avoid them
  ;vim:path=~/.vim/bundle/js-beautify/js/lib/beautify-html.js
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
default they are stet to 0 and `$`.

If you want beautify only selected lines you should use functions
**RangeJsBeautify**, **RangeCSSBeautify**, **RangeHtmlBeautify**.

Example of binding function for js, html and css in visual mode on <ctrl-f>

```vim
  ".vimrc
  autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
  autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
  autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
```


## Running tests
Tests are written in [Urchin](http://www.urchin.sh) for vim files and build in [Grunt](https://github.com/gruntjs/grunt) test runer for javascript files.
Note all commands bellow you should run from plugin directory.

Run vim tests with urchin.

    ./urchin test/vim

(Or put it some other place in your PATH.)

How run vim and javascript tests with [grunt](https://github.com/gruntjs/grunt).

    npm install -g grunt-cli
    npm install grunt
    npm install grunt-contrib-nodeunit
    npm install grunt-contrib-jshint
    npm install grunt-contrib-watch
    npm install grunt-contrib-uglify

    grunt test

Run only javascript tests.

    grunt nodeunit


Thanks for assistance:

+ [@stonelee](https://github.com/stonelee)
+ [@peterfoldi](https://github.com/peterfoldi)
+ [@edmistond](https://github.com/edmistond)


## Versions

v1.1.1
  + Add support js-beautify v1.3.1

## License

Licensed MIT
Copyright (c) 2012 Maksim Ryzhikov;
