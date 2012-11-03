Настройка
-------------

В версии 1.0 вся настройка ведется через файл .editorconfig.
Этот файл может находится либо в корневой папке пользователя ```~/.editorconfig```,
либо в папке .vim ```~/.vim/.editorconfig```.

Настройки берутся из секций [\*\*.js], [\*\*.css] и [\*\*.html]. Внутри этих
секций можно использовать специальный комментарий ```;vim:```, но такой комментарий
может быть использован только для глобальной настройки.

Так же можно настраивать через переменную ```g:config_Beautifier```, но лучше использовать .editorconfig файл.


### Примеры

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
  ; Путь до внешнего файла форматирования
  ; по умолчанию берется из папки lib внутри папки расширения.
  path=~/.vim/bundle/js-beautify/beautify.js
  ; Javascript интерпритатор который необходимо вызвать
  ; по умолчанию 'node'
  bin=node
  indent_style = space
  indent_size = 4

  [**.css]
  path=~/.vim/bundle/js-beautify/beautify-css.js
  indent_style = space
  indent_size = 4

  [**.html]
  ; Используя спейиальные коментарии
  ; такие комментраии применятся только при глобальной настройке
  ; поэтому лучше избегать их
  ;vim:path=~/.vim/bundle/js-beautify/beautify-html.js
  ;vim:max_char=78:brace_style=expand
  indent_style = space
  indent_size = 4

```
