let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_46/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_46'
  before
    new
  end

  after
    close!
  end


  it 'should correctly apply space for jsx format'
    setfiletype javascript
    read `='t/issue_46/file'`
    Expect JsxBeautify() == join(readfile('t/issue_46/expected'), "\n")
  end
end
