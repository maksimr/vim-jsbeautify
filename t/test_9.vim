let $HOME = '.'
filetype plugin on
let g:editorconfig_Beautifier = 't/test_9/.editorconfig'
runtime! plugin/beautifier.vim

describe 'test_9'
  before
    new
  end

  after
    close!
  end


  it 'It should never use multiple tabs for indentation'
    setfiletype javascript
    put = '(function(){return \"1\";}());'
    Expect JsBeautify() == "(function() {\n
                \\t\treturn \"1\";\n
                \}());"
  end
end
