let $HOME = '.'
filetype plugin on
runtime! plugin/beautifier.vim

describe 'Default settings'
  before
    new
  end

  after
    close!
  end


  it 'should format javascript file with default settings'
    setfiletype javascript
    put = '(function(){return \"1\";}());'
    Expect JsBeautify() == "(function() {\n
                \    return \"1\";\n
                \}());"
  end


  it 'should format css file with default settings'
    setfiletype css
    put = '.foo { padding: 10px; }'
    Expect CSSBeautify() == ".foo {\n
            \    padding: 10px;\n
            \}"
  end


  it 'should format html file with default settings'
    setfiletype css
    put = '<div> <p>Some Content</p> </div>'
    Expect HtmlBeautify() == "<div>\n
            \    <p>Some Content</p>\n
            \</div>"
  end


  it 'should restore position cursor'
    setfiletype javascript
    put = '(function(){return \"1\";}());'
    call setpos('.', [0,1,23,0])
    call JsBeautify()
    Expect getpos('.') == [0,1,1,0]
  end
end
