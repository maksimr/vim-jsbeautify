## vim-jsbeautify - v1.1.2 - 2016-06-05

[![Build Status](https://secure.travis-ci.org/maksimr/vim-jsbeautify.png)](http://travis-ci.org/maksimr/vim-jsbeautify)

## Description

This extension allows you to use [jsbeautifier] (http://jsbeautifier.org/)
inside vim to quickly format javascript, html and css files.
Version 1.0 also supports the [editorconfig] (http://editorconfig.org/) file.

Any comments, corrections and suggestions are welcome.

## Installation

### Dependencies

* A javascript interpreter: [nodejs] (http://nodejs.org/) or [v8] (http://code.google.com/p/v8/).
* [js-beautify](https://github.com/beautify-web/js-beautify)
* Optional: [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)

### Installing without plugin-manager

Download zip [file] (https://github.com/maksimr/vim-jsbeautify/archive/master.zip)
or clone project. Then copy `plugin` folder from the plugin's directory to your `~/.vim` folder.

``` bash
unzip vim-jsbeautify-master.zip
cd vim-jsbeautify-master
cp -r plugin ~/.vim/
```

Then download the zip file for [js-beautify](https://github.com/beautify-web/js-beautify/archive/master.zip) and place its contents in `~/.vim/plugin/lib/`, ie:
```bash
wget https://github.com/beautify-web/js-beautify/archive/master.zip && unzip master.zip && cp -rf js-beautify-master/ ~/.vim/plugin/lib/
```

### Installing using pathogen

```bash
cd ~/.vim/bundle
git clone https://github.com/maksimr/vim-jsbeautify.git
cd vim-jsbeautify && git submodule update --init --recursive
```

### Installing using vundle

1. Add this line to your `.vimrc`:

  ```vim
  Plugin 'maksimr/vim-jsbeautify'
  ```
  
2. Call `PluginInstall()` inside vim:

  ```vim
  :PluginInstall
  ```
  
3. Update git submodules: `cd ~/.vim/bundle/vim-jsbeautify && git submodule update --init --recursive`

## Settings

In version 1.0, all configuration is done through the `.editorconfig` file.
This file can be located either in the user home directory `~/.editorconfig`,
or in inside the vim configuration directory `~/.vim/.editorconfig`.

To assign a custom path for the `.editorconfig` file set the variable `g:editorconfig_Beautifier`.

Settings are taken from sections `[**.js]`, `[**.json]`, `[**.jsx]`, `[**.html]`, and `[**.css]`. Within these
sections can use a special comment `; vim:`, but this comment
can be used only for the global settings.

You can also configure a variable ```g: config_Beautifier```(g:config_Beautifier has type **dict**), but it is better to use the `.editorconfig` file.


### Examples

A simple example of the `.editorconfig` file:

```ini
;.editorconfig

root = true

[**.js]
indent_style = space
indent_size = 4

[**.json]
indent_style = space
indent_size = 4

[**.jsx]
e4x = true
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

The `.editorconfig` file uses special comments (```;vim:```)
and special properties for the jsbeautify plugin like ```path```, ```bin```

```ini
;.editorconfig

root = true

[**.js]
; path to optional external js beautifier, default is vim-jsbeautify/plugin/lib
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

## Usage

```vim
".vimrc
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
```

JsBeautify function takes two parameters: the starting line number and the ending line number. By
default these parameters are set to `0` and `$`.

If you want to beautify only selected lines you should use functions
**RangeJsBeautify**, **RangeJsonBeautify**, **RangeJsxBeautify**, **RangeHtmlBeautify**, or **RangeCSSBeautify**.

Example of binding a function for js, html and css in visual mode on <ctrl-f>

```vim
".vimrc
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
```

## Running tests

Tests are written in [Urchin](https://github.com/tlevine/urchin) for vim files and built using [Grunt](https://github.com/gruntjs/grunt) test runer for javascript files.
Note that all the commands bellow you should run from the plugin directory.

Run vim tests with urchin:

    ./urchin test/vim

(Or put it some other place in your PATH.)

How to run vim and javascript tests with [grunt](https://github.com/gruntjs/grunt):

    npm install -g grunt-cli
    npm install

    grunt test

Run only javascript tests:

    grunt nodeunit


Thanks for assistance:

+ [@stonelee](https://github.com/stonelee)
+ [@peterfoldi](https://github.com/peterfoldi)
+ [@edmistond](https://github.com/edmistond)


## Versions

v1.1.2
  + Add support js-beautify v1.6.3

v1.1.1
  + Add support js-beautify v1.3.1

## License

Licensed MIT
Copyright (c) 2016 Maksim Ryzhikov;
