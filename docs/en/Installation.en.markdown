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
