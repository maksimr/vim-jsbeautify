let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_143/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_143'
  before
    new
  end

  after
    close!
  end


  it 'should format typescript file'
    setfiletype typescript
    read `='t/issue_143/file.ts'`
    Expect JsBeautify() == join(readfile('t/issue_143/expected'), "\n")
  end
end
