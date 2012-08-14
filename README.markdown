vim-jsbeautify - v1.0.0 - 2012-08-15
---------------------------------------------------
[![Build Status](https://secure.travis-ci.org/maksimr/vim-jsbeautify.png)](http://travis-ci.org/maksimr/vim-jsbeautify)

Описание
------------

Это расширение позволяет вам использовать [jsbeautifier](http://jsbeautifier.org/)
внутри vim-а, что позволит вам быстро отформатировать javascript, html и css файлы.
А также с версии 1.0 имеет поддержку [editorconfig](http://editorconfig.org/) файла.

Любые замечания, исправления и пожелания только приветствуются.

Установка
------------

### Зависимости
Для того чтобы использовать это расширение вам необходимо
будет установить один из javascript интерпретаторов
[nodejs](http://nodejs.org/) или [v8](http://code.google.com/p/v8/).

### Установка используя pathogen

```bash

  cd ~/.vim/bundle
  git clone https://github.com/maksimr/vim-jsbeautify.git
  cd vim-jsbeautify && git submodule update --init --recursive

```

### Установка используя vundle

Просто добавьте одну строчку в ваш .vimrc.

```vim

  Bundle 'maksimr/vim-jsbeautify'

```

Также необходимо будет после установки расширения, перейти в его папку
и выполнить ```git submodule update --init --recursive``` или указать
при настройке путь до внешнего файла форматирования (будет показано ниже).

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

Использование
-------------

```vim
  ".vimrc

  map <c-f> :call JsBeautify()<cr>
  " или
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  " для html
  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " для css или scss
  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

```

Функция JsBeautify принимает два параметра, это номера начальной и конечной линии.
По умолчанию 0 и '$'.


[Website](http://github.com/)

Copyright (c) 2012 Maksim Ryzhikov; Licensed MIT
