/**
 * Spec jsbeautify.vim.
 *
 * test covered:
 *  + node 0.6.18
 *  + node 0.8.1
 */

(function() {
    var system = require('child_process').exec,
        conf = require('./conf.json'),
        helpers = require('./helpers'),
        print = helpers.print,
        mixin = helpers.mixin,

        /**
         * Common test spec.
         */
        testCase = {
            'beautify JS': function(test) {
                var contentPath = 'test/javascript/templates/test.js',
                    command = this.command;

                test.expect(1);
                command = print(command, conf.plugin, contentPath, {}, conf.beautify.js_path);

                /**
                 * Should simple format file.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '(["foo", "bar"]).each(function(i) {\n    return i;\n});', 'should be formatted string.');
                    test.done();
                });
            },
            'beautify JS with options': function(test) {
                var contentPath = 'test/javascript/templates/test.js',
                    command = this.command,
                    options = '{"indent_size": 2, "indent_char": "\t"}';

                test.expect(1);
                command = print(command, conf.plugin, contentPath, options, conf.beautify.js_path);

                /**
                 * Should format string
                 * and change white space on tabulation chars.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '(["foo", "bar"]).each(function(i) {\n\t\treturn i;\n});', 'should be formatted string with tab.');
                    test.done();
                });
            },
            'beautify HTML': function(test) {
                var contentPath = 'test/javascript/templates/test.html',
                    command = this.command;

                test.expect(1);
                command = print(command, conf.plugin, contentPath, {}, conf.beautify.html_path);

                /**
                 * Should simple format file.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '<div>foo\n    <div></div>\n</div>', 'should be formatted string.');
                    test.done();
                });
            },
            'beautify HTML with options': function(test) {
                var contentPath = 'test/javascript/templates/test.html',
                    command = this.command,
                    options = '{"indent_size": 2, "indent_char": "\t"}';

                test.expect(1);
                command = print(command, conf.plugin, contentPath, options, conf.beautify.html_path);

                /**
                 * Should format string
                 * and change white space on tabulation chars.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '<div>foo\n\t\t<div></div>\n</div>', 'should be formatted string with tab.');
                    test.done();
                });
            },
            'HtmlBeautify() adding extra newline (issue 36)': function(test) {
                var contentPath = 'test/javascript/templates/issue_36.html',
                    command = this.command;

                test.expect(1);
                command = print(command, conf.plugin, contentPath, {}, conf.beautify.html_path);

                /**
                 * Should simple format file.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '<div>foo\n    <div></div>\n</div>', 'should save additional newline.');
                    test.done();
                });
            },
            'beautify CSS': function(test) {
                var contentPath = 'test/javascript/templates/test.css',
                    command = this.command;

                test.expect(1);
                command = print(command, conf.plugin, contentPath, {}, conf.beautify.css_path);

                /**
                 * Should simple format file.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '.foo {\n    padding: 0;\n}', 'should be formatted string.');
                    test.done();
                });
            },
            'beautify CSS with options': function(test) {
                var contentPath = 'test/javascript/templates/test.css',
                    command = this.command,
                    options = '{"indent_size": 2, "indent_char": "\t"}';

                test.expect(1);
                command = print(command, conf.plugin, contentPath, options, conf.beautify.css_path);

                /**
                 * Should format string
                 * and change white space on tabulation chars.
                 */
                system(command, function(err, stdout, stderr) {
                    stdout = err || stderr || stdout;
                    test.equal(stdout, '.foo {\n\t\tpadding: 0;\n}', 'should be formatted string with tab.');
                    test.done();
                });
            }
        };

    /**
     * Test for node
     */
    exports.node = mixin({
        setUp: function(done) {
            this.command = 'node ${0} --js_arguments ${1} ${2} ${3}';
            done();
        }
    }, testCase);
}(this));
