let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
runtime! plugin/beautifier.vim

describe 'issue_39'
  before
    new
  end

  after
    close!
  end


  it 'should set zero status code'
    setfiletype javascript
    call JsBeautify()
    Expect v:shell_error == 0
  end
end
