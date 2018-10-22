let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_21/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_21'
  before
    new
  end

  after
    close!
  end


  it 'should support indent_style = tab in .editorconfig file'
    setfiletype javascript
    read `='t/issue_21/file'`
    Expect JsBeautify() == join(readfile('t/issue_21/expected'), "\n")
  end
end
