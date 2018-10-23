let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_139/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_139'
  before
    new
  end

  after
    close!
  end


  it 'should not messing up jsx code'
    setfiletype javascript
    read `='t/issue_139/file'`
    Expect JsxBeautify() == join(readfile('t/issue_139/expected'), "\n")
  end
end
