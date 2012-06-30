" Vim plugin
" Language:	javascript, html, css
" Maintainer:	Maksim Ryzhikov <rv.maksim@gmail.com>
" License: MIT
" Version: 0.1.5
"
" Need reduce count of global variables, change
" their on function.

" Only do this when not done yet for this buffer
if exists("JsBeautify") || exists("HtmlBeautify") || exists("CSSBeautify")
  finish
endif


let s:pluginDir = fnamemodify(expand("<sfile>"), ":h")

let s:jsbeautify = {"indent_size": 4, "indent_char": " "}
let s:htmlbeautify = {"indent_size": 4, "indent_char": " ", "max_char": 78, "brace_style": "expand", "unformatted": []}
let s:cssbeautify = {"indent_size": 4, "indent_char": " "}

" engine for interpretation javascript
" support nodejs or v8
if !exists('g:jsbeautify_engine')
  let g:jsbeautify_engine = "node"
endif

" path to jsbeautify file by default look it submodule lib
if !exists('g:jsbeautify_file')
  let g:jsbeautify_file = fnameescape(s:pluginDir."/lib/beautify.js")
endif
if !exists('g:htmlbeautify_file')
  let g:htmlbeautify_file = fnameescape(s:pluginDir."/lib/beautify-html.js")
endif
if !exists('g:cssbeautify_file')
  let g:cssbeautify_file = fnameescape(s:pluginDir."/lib/beautify-css.js")
endif

" temporary file for content
if !exists('g:jsbeautify_log_file')
  let g:jsbeautify_log_file = fnameescape(tempname())
endif

" mixin dictionary
fun! s:mixin(gconf,uconf)
  if type(a:gconf) == 4 && type(a:uconf) == 4
    for key in keys(a:uconf)
      let a:gconf[key] = a:uconf[key]
    endfor

    return a:gconf
  endif
endfun

" check type of files
func! s:isAllowedType(type)
  let haz = 1

  if !(a:type == 'js' || a:type == 'css' || a:type == 'html')
    let haz = 0
  endif

  return haz
endfun


" quote string
fun! s:quote(str)
  return '"'.escape(a:str,'"').'"'
endfun

" @description Format the javascript file
"
" @param {[Number|String]} a:0 Default value '1'
" @param {[Number|String]} a:1 Default value '$'
fun! JsBeautify(...)
  return call('Beautify', extend(['js'], a:000))
endfun

fun! HtmlBeautify(...)
  return call('Beautify', extend(['html'], a:000))
endfun

fun! CSSBeautify(...)
  return call('Beautify', extend(['css'], a:000))
endfun

" @param {[Number|String]} a:0 Default value '1'
" @param {[Number|String]} a:1 Default value '$'
" @param {[String]} a:2 type of file
fun! Beautify(...)
  let line1 = get(a:000, 1, '1')
  let line2 = get(a:000, 2, '$')

  " define type of file
  let type = get(a:000, 0, expand('%:e'))

  " define parameters are depended from type of file
  if type == 'js'
    call s:jsmixin()
    let _opts = s:jsbeautify
    let path = g:jsbeautify_file
  elseif type == 'html'
    call s:htmlmixin()
    let _opts = s:htmlbeautify
    let path = g:htmlbeautify_file
  elseif type == 'css'
    call s:cssmixin()
    let _opts = s:cssbeautify
    let path = g:cssbeautify_file
  else
    return
  endif

  let opts = string(_opts)
  let opts = substitute(opts,"'",'"','g')
  let opts = s:quote(opts)

  let plen = len(getline(line1, line2))
  let content = getline(line1, line2)

  call writefile(content, g:jsbeautify_log_file)

  let path = s:quote(path)
  let content_path = s:quote(g:jsbeautify_log_file)


  if (executable(g:jsbeautify_engine))
    let res = system(g:jsbeautify_engine." ".fnameescape(s:pluginDir."/beautify.min.js")." --js_arguments ".content_path." ".opts." ".path)
  else
    echo "Command ".g:jsbeautify_engine." doesn't exist!"
    return
  endif

  let lines = split(res, "\n")

  call setline(line1, lines)

  " delete excess lines
  if plen > len(lines)
    let endline = len(lines) + 1
    silent exec endline.",$g/.*/d"
  endif

endfun

func! s:jsmixin()
  if exists('g:jsbeautify')
    call s:mixin(s:jsbeautify, g:jsbeautify)
  endif
endfun

func! s:htmlmixin()
  if exists('g:htmlbeautify')
    call s:mixin(s:htmlbeautify, g:htmlbeautify)
  endif
endfun

func! s:cssmixin()
  if exists('g:cssbeautify')
    call s:mixin(s:cssbeautify, g:cssbeautify)
  endif
endfun

" editorconfig hook
" Intergration with editorconfig.
" https://github.com/editorconfig/editorconfig-vim.git
func! BeautifyEditorconfigHook(config)
  let type = expand('%:e')

  if !(type(a:config) == 4 && s:isAllowedType(type) && len(a:config))
    return 1
  endif

  let config = s:mixin({}, a:config)

  if has_key(config, 'indent_size')
    if config["indent_style"] == 'space'
      let config["indent_char"] = ' '
    elseif config["indent_style"] == 'tab'
      let config["indent_char"] = '\t'
    endif
  endif


  " Rewrite global config variable
  if type == 'js'
    let g:jsbeautify = config
  elseif type == 'html'
    let g:cssbeautify = config
  elseif type == 'css'
    let g:htmlbeautify = config
  endif

  " All Ok! retun 0
  return 0
endfun

let FHook = function('BeautifyEditorconfigHook')

if exists('g:loaded_EditorConfig')
  call editorconfig#AddNewHook(FHook)
endif

" mix user configuration with script configuration
call s:jsmixin()
call s:htmlmixin()
call s:cssmixin()
