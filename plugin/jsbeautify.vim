" Vim plugin
" Language:	javascript
" Maintainer:	Maksim Ryzhikov <rv.maksim@gmail.com>
" License: MIT
" Version: 0.1.1

" Only do this when not done yet for this buffer
if exists("JsBeautify")
  finish
endif


let s:pluginDir = fnamemodify(expand("<sfile>"), ":h")
let s:jsbeautify = {"indent_size": 4, "indent_char": " "}

" engine for interpretation javascript
" support nodejs or v8
if !exists('g:jsbeautify_engine')
  let g:jsbeautify_engine = "node"
endif

" path to jsbeautify file by default look it submodule lib
if !exists('g:jsbeautify_file')
  let g:jsbeautify_file = fnameescape(s:pluginDir."/lib/beautify.js")
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
  endif
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
  let line1 = get(a:000, 0, '1')
  let line2 = get(a:000, 1, '$')

  let opts = string(s:jsbeautify)
  let opts = substitute(opts,"'",'"','g')
  let opts = s:quote(opts)

  let plen = len(getline(line1, line2))
  let content = getline(line1, line2)

  call writefile(content, g:jsbeautify_log_file)

  let path = s:quote(g:jsbeautify_file)
  let content_path = s:quote(g:jsbeautify_log_file)


  if (executable(g:jsbeautify_engine))
    let res = system(g:jsbeautify_engine." ".fnameescape(s:pluginDir."/beautify-min.js")." --js_arguments ".content_path." ".opts." ".path)
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

" mix user configuration with script configuration
if exists('g:jsbeautify')
  call s:mixin(s:jsbeautify, g:jsbeautify)
endif
