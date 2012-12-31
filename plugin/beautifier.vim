"% Preliminary validation of global variables
"  and version of the editor.

if v:version < 700
  finish
endif

" check whether this script is already loaded
if exists('g:loaded_Beautifier')
  finish
endif

let g:loaded_Beautifier = 1

if !exists('g:config_Beautifier')
  let g:config_Beautifier = {}
endif

if !exists('g:editorconfig_Beautifier')
  let g:editorconfig_Beautifier = ''
endif

" temporary file for content
if !exists('g:tmp_file_Beautifier')
  let g:tmp_file_Beautifier = fnameescape(tempname())
endif



"% Helper functions and variables
let s:plugin_Root_direcoty = fnamemodify(expand("<sfile>"), ":h")
let s:paths_Editorconfig = map(['~/.editorconfig', '~/.vim/.editorconfig', s:plugin_Root_direcoty.'/.editorconfig'], 'expand(v:val)')

" Function for debugging
" @param {Any} content Any type which will be converted
" to string and write to tmp file
func! s:console(content)
  let log_dir = fnameescape('/tmp/vimlog')
  call writefile([string(a:content)], log_dir)
  return 1
endfun

" Output warning message
" @param {Any} message The warning message
fun! WarningMsg(message)
  echohl WarningMsg
  echo string(a:message)
endfun

" Output error message
" @param {Any} message The error message
fun! ErrorMsg(message)
  echoerr string(a:message)
endfun

" Check type of files
" @param {String} type The verified type
" @param {[List]} The list of allowed types
"
" @return {Boolean} Is the type in list of allowed types
func! s:isAllowedType(type, ...)
  let haz = 1
  let type = a:type
  let allowedTypes = get(a:000, 1, ['js', 'css', 'html'])

  return index(allowedTypes, type) != -1
endfun

" Quoting string
" @param {String} str Any string
" @return {String} The quoted string
func! s:quote(str)
  return '"'.escape(a:str,'"').'"'
endfun

" @param {String} The content of .editorconfig file
" @return {Dict} The configuration object based
" on content the file.
func! s:processingEditconfigFile(content)
  let opts = {}
  let content = a:content

  for type in ['js', 'css', 'html']
    " Get settings for javascript files
    " collect all data after [**.js] to
    " empty string
    let index = index(content, '[**.'.type.']')

    if index == -1
      continue
    endif

    let l:value = {}

    " line with declaration [**.type]
    " we shoul skip.
    let index = index + 1
    let line = get(content, index)

    " if string start with bracket
    " then we assumes that it's
    " start new logical section
    " and break processing
    while (strpart(line, 0, 1) != '[' && index <= len(content))

      if (!empty(matchstr(line, ';\(vim:\)\@!')) || empty(line))
        " if we meet comment which is don't
        " special comment or empty string
        " then stop processing this line
        let index = index + 1
        let line = get(content, index)
        continue
      endif

      " special comment should look like
      " ';vim:key=value:second=value'
      if strpart(line, 0, 1) == ';'
        " if it's special comment then procesisng
        " it separate and continue processing
        let l:copts = split(strpart(line, 5), ':')

        for part in l:copts
          let data = split(part, '\s*=\s*')
          let l:value[get(data, 0)] = get(data, 1)
        endfor
      else
        " else we assumes that it is
        " .editorconfig setting
        let data = split(line, '\s*=\s*')
        let l:value[get(data, 0)] = get(data, 1)
      endif

      let index = index + 1
      let line = get(content, index)
    endwhile

    let opts[type] = l:value
  endfor

  return opts
endfun

" Метод которые обновляет
" скриптовой 'приватный' объект
" конфигурации
"
" param {Dict} value The configuration object.
" return {Dict} Return copy of configuration obect with link on
" old config or empty object.
function s:updateConfig(value)
  if empty(a:value)
    return a:value
  endif

  " Делаем копию объекта
  let b:config_Beautifier = deepcopy(a:value)

  return b:config_Beautifier
endfunction

" Get default path
" @param {String} type Some of the types js, html or css
func s:getPathByType(type)
  let path = ''
  let type = a:type
  let rootPtah = s:plugin_Root_direcoty."/lib/"

  if type == 'js'
    let path = rootPtah."beautify.js"
  elseif type == 'html'
    let path = rootPtah."beautify-html.js"
  elseif type == 'css'
    let path = rootPtah."beautify-css.js"
  endif

  return path
endfunc



" Helper functions for restoring mark and cursor position
function! s:getNumberOfNonSpaceCharactersFromTheStartOfFile(position)
  let cursorRow = a:position.line
  let cursorColumn = a:position.column
  let lineNumber = 1
  let nonBlankCount = 0
  while lineNumber <= cursorRow
    let lineContent = getline(lineNumber)
    if lineNumber == cursorRow
      let lineContent = strpart(lineContent,0,cursorColumn)
    endif
    let charIndex = 0
    while charIndex < len(lineContent)
      let char = strpart(lineContent,charIndex,1)
      if match(char,'\s\|\n\|\r') == -1
        let nonBlankCount = nonBlankCount + 1
      endif
      let charIndex = charIndex + 1
    endwhile
    "echo nonBlankCount
    let lineNumber = lineNumber + 1
  endwhile
  return nonBlankCount
endfunction



"Converts number of non blank characters to cursor position (line and column)
function! s:getCursorPosition(numberOfNonBlankCharactersFromTheStartOfFile)
  "echo a:numberOfNonBlankCharactersFromTheStartOfFile
  let lineNumber = 1
  let nonBlankCount = 0
  while lineNumber <= line('$')
    let lineContent = getline(lineNumber)
    let charIndex = 0
    while charIndex < len(lineContent)
      let char = strpart(lineContent,charIndex,1)
      if match(char,'\s\|\n\|\r') == -1
        let nonBlankCount = nonBlankCount + 1
      endif
      let charIndex = charIndex + 1
      if nonBlankCount == a:numberOfNonBlankCharactersFromTheStartOfFile 
        "echo 'found position!'
        return {'line': lineNumber,'column': charIndex}
      end
    endwhile
    let lineNumber = lineNumber + 1
  endwhile
  "echo "Oops, nothing found!"
endfunction



"Restoring current position by number of non blank characters
function! s:setNumberOfNonSpaceCharactersBeforeCursor(mark,numberOfNonBlankCharactersFromTheStartOfFile)
  let location = s:getCursorPosition(a:numberOfNonBlankCharactersFromTheStartOfFile)
  call setpos(a:mark, [0, location.line, location.column, 0])
endfunction



function! s:getCursorAndMarksPositions()
  let localMarks = map(range(char2nr('a'), char2nr('z'))," \"'\".nr2char(v:val) ") 
  let marks = ['.'] + localMarks
  let result = {}
  for positionType in marks
    let cursorPositionAsList = getpos(positionType)
    let cursorPosition = {'buffer': cursorPositionAsList[0], 'line': cursorPositionAsList[1], 'column': cursorPositionAsList[2]}
    if cursorPosition.buffer == 0 && cursorPosition.line > 0
      let result[positionType] = cursorPosition
    endif
  endfor
  return result
endfunction




"% Declaring global variables and functions

" Apply settings from 'editorconfig' file to beautifier.
" @param {String} filepath path to configuration 'editorconfig' file.
" @return {Number} If apply was success then return '0' else '1'
function BeautifierApplyConfig(...)

  " Получаем путь который нам передали
  let l:filepath = get(a:000, 0)

  " Проходимся по дефолтным путям только если
  " оказалось что нам не передали путь
  "
  " Если нам передали путь то не стоит его
  " тут проверять на сушествование
  if empty(l:filepath)
    let l:filepath = get(filter(copy(s:paths_Editorconfig),'filereadable(v:val)'), 0)
  endif

  if !filereadable(l:filepath)
    " File doesn't exist then return '1'
    call WarningMsg('Can not find global .editorconfig file!')
    return 1
  endif


  let l:content = readfile(l:filepath)

  " Process .editorconfig file
  let opts = s:processingEditconfigFile(l:content)

  let g:config_Beautifier = opts
  call s:updateConfig(opts)

  " All Ok! return '0'
  return 0
endfunction


" Common function for beautify
" @param {String} type The type of file js, css, html
" @param {[String]} line1 The start line from which will start
" formating text, by default '1'
" @param {[String]} line2 The end line on which stop formating,
" by default '$'
func! Beautifier(...)
  let cursorPositions = s:getCursorAndMarksPositions()
  call map(cursorPositions, " extend (v:val,{'characters': s:getNumberOfNonSpaceCharactersFromTheStartOfFile(v:val)}) ")
  if !exists('b:config_Beautifier')
    call s:updateConfig(g:config_Beautifier)
  endif

  " Define type of file
  let type = get(a:000, 0, expand('%:e'))
  let allowedTypes = get(b:config_Beautifier[type], 'extensions')

  if !s:isAllowedType(type, allowedTypes)
    call WarningMsg('File type is not allowed!')
    return 1
  endif

  let line1 = get(a:000, 1, '1')
  let line2 = get(a:000, 2, '$')

  let opts = b:config_Beautifier[type]
  let path = get(opts, 'path', s:getPathByType(type))
  let path = expand(path)
  let path = fnameescape(path)
  " Get external engine which will
  " be execute javascript file
  " by default get node
  let engine = get(opts, 'bin', 'node')

  " Get content from the files
  let content = getline(line1, line2)

  " Length of lines before beautify
  let lines_length = len(getline(line1, line2))

  " Write content to temporary file
  call writefile(content, g:tmp_file_Beautifier) 
  " String arguments which will be passed
  " to external command

  " TODO make valid json
  let opts_Beautifier_arg = substitute(string(opts), "'[", '[', 'g')
  let opts_Beautifier_arg = substitute(opts_Beautifier_arg, "]'", ']', 'g')

  let opts_Beautifier_arg = substitute(opts_Beautifier_arg, "'", '"', 'g')
  let opts_Beautifier_arg = s:quote(opts_Beautifier_arg)
  let path_Beautifier_arg = s:quote(path)
  let tmp_file_Beautifier_arg = s:quote(g:tmp_file_Beautifier)



  if executable(engine)
    let result = system(engine." ".fnameescape(s:plugin_Root_direcoty."/beautify.min.js")." --js_arguments ".tmp_file_Beautifier_arg." ".opts_Beautifier_arg." ".path_Beautifier_arg)
  else
    " Executable bin doesn't exist
    call ErrorMsg('The '.engine.' is not executable!')
    return 1
  endif

  let lines_Beautify = split(result, "\n")

  call setline(line1, lines_Beautify)

  " delete excess lines
  if lines_length > len(lines_Beautify)
    let endline = len(lines_Beautify) + 1
    silent exec endline.",$g/.*/d"
  endif

  for [key,value] in items(cursorPositions)
    call s:setNumberOfNonSpaceCharactersBeforeCursor(key,value.characters)
  endfor
  return result
endfun

" editorconfig hook
" Intergration with editorconfig.
" https://github.com/editorconfig/editorconfig-vim.git
func! BeautifierEditorconfigHook(config)
  let type = expand('%:e')
  let config = a:config

  if !(type(config) == 4)
    return 1
  endif

  if !s:isAllowedType(type)
    return 1
  endif


  " If buffer config variable does not exist
  " then let it
  if !exists('b:config_Beautifier')
    let b:config_Beautifier = deepcopy(g:config_Beautifier)
  endif

  if !len(config)
    call s:updateConfig(g:config_Beautifier)
    return 1
  endif

  if empty(get(b:config_Beautifier, type))
    call WarningMsg('Type '.type.' is not presented in config')
    return 1
  endif

  let config = extend(b:config_Beautifier[type], config)

  " TODO:1 Need set this checking
  " when we update config because user
  " may set 'tab' in global .editorconfig without editorconfig plugin
  if has_key(config, 'indent_style')
    if config["indent_style"] == 'space'
      let config["indent_char"] = ' '
    elseif config["indent_style"] == 'tab'
      let config["indent_char"] = '\t'
      " When the indent_char is tab, we always want to use 1 tab
      let config["indent_size"] = 1
    endif
  endif

  let b:config_Beautifier[type] = config

  " All Ok! retun 0
  return 0
endfun

" @param {[Number|String]} a:0 Default value '1'
" @param {[Number|String]} a:1 Default value '$'
fun! JsBeautify(...)
  return call('Beautifier', extend(['js'], a:000))
endfun

fun! HtmlBeautify(...)
  return call('Beautifier', extend(['html'], a:000))
endfun

fun! CSSBeautify(...)
  return call('Beautifier', extend(['css'], a:000))
endfun

" Check if installed editorconfig plugin
" then add hook on change
try
  let BeautifierHook = function('BeautifierEditorconfigHook')
  call editorconfig#AddNewHook(BeautifierHook)
catch
endt

"XXX: legacy block code
"yet retain support old config
fun! LegacyMsg()
  call WarningMsg('beautifier.vim#Please use .editorconfig for default settings')
endfun

if exists('g:jsbeautify')
  let g:config_Beautifier['js'] = g:jsbeautify
  if exists('g:jsbeautify_file')
    let g:config_Beautifier['js']['path'] = g:jsbeautify_file
  endif
  call LegacyMsg()
endif

if exists('g:htmlbeautify')
  let g:config_Beautifier['html'] = g:htmlbeautify
  if exists('g:htmlbeautify_file')
    let g:config_Beautifier['html']['path'] = g:htmlbeautify_file
  endif
  call LegacyMsg()
endif

if exists('g:htmlbeautify')
  let g:config_Beautifier['css'] = g:cssbeautify
  if exists('g:cssbeautify_file')
    let g:config_Beautifier['css']['path'] = g:cssbeautify_file
  endif
  call LegacyMsg()
endif
"XXX: end

" If user doesn't set config_Beautifier in
" .vimrc then look up it in .editorconfig
if empty(g:config_Beautifier)
  call BeautifierApplyConfig(g:editorconfig_Beautifier)
endif
