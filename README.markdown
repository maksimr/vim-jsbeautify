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
  let g:jsbeautify_file = fnameescape(fnamemodify(expand("<sfile>"), ":h")."/bundle/js-beautify/beautify.js")

```

Configuration
-------------

Configuration jsbeautify

```vim
  ".vimrc

  let g:jsbeautify = {"indent_size": 4, "indent_char": "\t"}

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

```

Function JsBeautify takes two parameters. First `start line` second `end line`,
by default `start line` equal '0' and `end line` equal '$'

##VERSIONS

0.1.1: Fix bug with escape in shell

(version: 0.1.1)
