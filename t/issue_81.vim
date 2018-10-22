let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_81/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_81'
  before
    new
  end

  after
    close!
  end


  it 'should format convert insert_final_newline to end_with_newline'
    setfiletype javascript
    read `='t/issue_81/file'`
    Expect JsBeautify() == join(readfile('t/issue_81/expected'), "\n")
  end
end
