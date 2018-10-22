let $HOME = '.'
filetype plugin on
let g:editorconfig_Beautifier = 't/.editorconfig'
runtime! plugin/beautifier.vim

describe 'Editorconfig'
  before
    new
  end

  after
    close!
  end


  it 'should format javascript file with editorconfig settings'
    setfiletype javascript
    put = '(function (global) { var $ = global.jQuery; if(!$){ return [ ''some'',   ''content'']; } $(''.class'') .addClass(''myclass'') .removeClass(''deleted''); }(this));'
    Expect JsBeautify() == "(function (global) {
            \\n  var $ = global.jQuery;
            \\n  if (!$) {
            \\n    return ['some', 'content'];
            \\n  }
            \\n  $('.class').addClass('myclass').removeClass('deleted');
            \\n}(this));"
  end


  it 'should format css file with editorconfig settings'
    setfiletype css
    put = '.foo{padding-top: 10px;}'
    Expect CSSBeautify() == ".foo {\n
            \  padding-top: 10px;\n
            \}"
  end


  it 'should format html file with editorconfig settings'
    setfiletype css
    put = '<!DOCTYPE HTML> <html lang=\"en\"> <head> <meta charset=\"UTF-8\"> <title></title> </head> <body> <div>Content</div> <a href=\"test\">Link</a> <span>Some string</span> </body> </html>'
    Expect HtmlBeautify() == "
                \<!DOCTYPE HTML>
                \\n<html lang=\"en\">
                \\n
                \\n<head>
                \\n  <meta charset=\"UTF-8\">
                \\n  <title></title>
                \\n</head>
                \\n
                \\n<body>
                \\n  <div>Content</div> <a href=\"test\">Link</a>
                \\n  <span>Some string</span>
                \\n</body>
                \\n
                \\n</html>"
  end
end
