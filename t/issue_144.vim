let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_144/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_144'
  before
    new
  end

  after
    close!
  end


  it 'should apply brace_style collapse-preserve-inline'
    setfiletype javascript
    read `='t/issue_144/file'`
    Expect JsBeautify() == join(readfile('t/issue_144/expected'), "\n")
  end
end
