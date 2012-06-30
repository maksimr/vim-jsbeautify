"% Preliminary validation of global variables
"  and version of the editor.

if v:version < 700
  finish
endif

" check whether this script is already loaded
if exists("g:loaded_Beautifier")
  finish
endif

g:loaded_Beautifier = 1

"% Declaring global variables and functions

" >beautifier#set
"
" Setter function.
" Through her set configuration values.
"
" @param {String} fileType The file type or path to
" configuration file.
"
" @param {Dictionary} dict The options which will be
" mixin to for beautifier.
function beautifier#set(fileType, dict)
endfunction
