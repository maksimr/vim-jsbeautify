vim-jsbeautify.vim
============

## About

Vim plugin based on js-beautify

For more info, online demo and tests see [http://jsbeautifier.org/](online javascript beautifier)

Installation
------------


### With Pathogen

```
cd ~/.vim/bundle
git clone https://github.com/maksimr/vim-jsbeautify.git
cd vim-jsbeautify && git submodule foreach git pull
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
  let g:htmlbeautify = {'indent_size': 4, 'indent_char': ' '}
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

(version: 0.1.3)
