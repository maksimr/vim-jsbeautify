let $HOME = fnamemodify(expand("<sfile>"), ":h")
filetype plugin on
let g:editorconfig_Beautifier = 't/issue_25/.editorconfig'
runtime! plugin/beautifier.vim

describe 'issue_25'
  before
    new
  end

  after
    close!
  end


  it 'should Not throw error if any section (js, html, css) is empty in .editorconfig'
    setfiletype html
    read `='t/issue_25/file'`
    Expect HtmlBeautify() == join(readfile('t/issue_25/expected'), "\n")
  end
end
