vim-jsbeautify.vim
============

Installation
------------

Configuration
-------------

configurate jsbeautify

```vim
  ".vimrc

  let g:jsbeautify = {"indent_size": 4, "indent_char": "\t"}

```
You can choose javascript interpretator nodejs or v8 (by default nodejs)
and set command in you vimrc

```vim
  ".vimrc

  let g:jsbeautify_engine = "v8"

  " or if you have other alias
  let g:jsbeautify_engine = "v8-alias"

```
(version: 0.1)
