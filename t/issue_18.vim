let $HOME = '.'
filetype plugin on
runtime! plugin/beautifier.vim

describe 'issue_18'
  before
    new
  end

  after
    close!
  end


  it 'It should not throw error'
    setfiletype javascript
    set maxmempattern=200000
    read `='t/issue_18/file'`
    Expect JsBeautify() == join(readfile('t/issue_18/expected'), "\n")
  end
end
