let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
runtime! plugin/beautifier.vim

describe 'issue_55'
  before
    new
  end

  after
    close!
  end


  it 'should format jsx file with default settings'
    setfiletype jsx
    read `='t/issue_55/file'`
    Expect JsxBeautify() == join(readfile('t/issue_55/expected'), "\n")
  end
end
