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
