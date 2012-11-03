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
