let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_29/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_29'
  before
    new
  end

  after
    close!
  end


  it 'should treat false values from editorconfig as boolean false not a string "false"'
    setfiletype javascript
    read `='t/issue_29/file'`
    Expect JsBeautify() == join(readfile('t/issue_29/expected'), "\n")
  end
end
