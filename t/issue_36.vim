let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
runtime! plugin/beautifier.vim

describe 'issue_36'
  before
    new
  end

  after
    close!
  end


  it 'should not add extra new line'
    setfiletype html
    read `='t/issue_36/file'`
    Expect HtmlBeautify() == join(readfile('t/issue_36/expected'), "\n")
  end
end
