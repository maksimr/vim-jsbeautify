vim-jsbeautify.vim
============

Installation
------------

You must have installed one of javascript interpretators nodejs or v8

If you use vundle simple put this string in your `vimrc`:

```vim

  Bundle 'maksimr/jsbeautify'

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

  let g:jsbeautify_engine = "v8"

  " or if you have other alias
  let g:jsbeautify_engine = "v8-alias"

```

Usage

```vim
  ".vimrc

  map <c-f> :call JsBeautify()<cr>

```

Function JsBeautify take two parameters first `start line` second `end line`,
by default `start line` equal '0' and `end line` equal '$'

(version: 0.1)
