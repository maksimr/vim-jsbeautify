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
