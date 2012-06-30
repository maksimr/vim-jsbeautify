vim-jsbeautify.vim
============

[![Build Status](https://secure.travis-ci.org/maksimr/vim-jsbeautify.png)](http://travis-ci.org/maksimr/vim-jsbeautify)

## About
This plugin uses [jsbeautifier](http://jsbeautifier.org/) to format javascript, html and css files.
To use it you must install either [nodejs](http://nodejs.org/) or [google v8 javascript engine](http://code.google.com/p/v8/).
There is also an integration with [editorconfig](http://editorconfig.org/).

Any requests, suggestions and bug reports are welcome.

Installation
------------

### With Pathogen

```
cd ~/.vim/bundle
git clone https://github.com/maksimr/vim-jsbeautify.git
cd vim-jsbeautify && git submodule update --init --recursive
```

### With Vundle
Add this to .vimrc:

```vim

  Bundle 'maksimr/vim-jsbeautify'

  " and go to plugin direcotory and run git submodule foreach git pull

```
or (recomended)

```vim

  Bundle 'maksimr/vim-jsbeautify'
  Bundle 'einars/js-beautify'

  " set path to js-beautify file
  let s:rootDir = fnamemodify(expand("<sfile>"), ":h")
  let g:jsbeautify_file = fnameescape(s:rootDir."/bundle/js-beautify/beautify.js")
  let g:htmlbeautify_file = fnameescape(s:rootDir."/bundle/js-beautify/beautify-html.js")
  let g:cssbeautify_file = fnameescape(s:rootDir."/bundle/js-beautify/beautify-css.js")

```

Configuration
-------------

Configuration jsbeautify

```vim
  ".vimrc

  let g:jsbeautify = {'indent_size': 4, 'indent_char': '\t'}
  let g:htmlbeautify = {'indent_size': 4, 'indent_char': ' ', 'max_char': 78, 'brace_style': 'expand', 'unformatted': ['a', 'sub', 'sup', 'b', 'i', 'u']}
  let g:cssbeautify = {'indent_size': 4, 'indent_char': ' '}


```

Run on v8

```vim
  ".vimrc

  " by default
  let g:jsbeautify_engine = "node"

  " If you bin name for node is nodejs
  let g:jsbeautify_engine = "nodejs"

  let g:jsbeautify_engine = "v8"

  " or if you have other alias
  let g:jsbeautify_engine = "v8-alias"

```

Usage

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

Function JsBeautify takes two parameters. First `start line` second `end line`,
by default `start line` equal '0' and `end line` equal '$'

##VERSIONS

* 0.1.1: Fix bug with escape in shell
* 0.1.2: Add support html beautifier and global function Beautify(type,start_line, end_line) where type is js, html or css, all params optional
* 0.1.3: Add support css beautifier
* 0.1.4: Add tests (thanks @benja2729 fix issue #1)
* 0.1.5: Add intergration with [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim#readme).
More about [editorconfig](http://editorconfig.org/)

(version: 0.1.5)
