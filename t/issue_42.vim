let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
runtime! plugin/beautifier.vim

describe 'issue_42'
  before
    new
  end

  after
    close!
  end


  it 'should not try append line to file if beautifer return empty string'
    setfiletype javascript
    Expect JsBeautify() == ''
  end
end
