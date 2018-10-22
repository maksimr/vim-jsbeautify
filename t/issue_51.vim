let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
runtime! plugin/beautifier.vim

describe 'issue_51'
  before
    new
  end

  after
    close!
  end


  it 'should format json'
    setfiletype javascript
    read `='t/issue_51/file'`
    Expect JsonBeautify() == join(readfile('t/issue_51/expected'), "\n")
  end
end
