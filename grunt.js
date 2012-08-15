/**
 * Project configuration.
 * @param {Object} grunt The global object.
 *
 * 2012-06-30
 */

module.exports = function(grunt) {

    grunt.initConfig({
        /**
         * Meta information about plugin.
         */
        meta: {
            name: 'vim-jsbeautify',
            website: 'github.com',
            author: 'Maksim Ryzhikov',
            version: '1.0.0',
            banner: '<%= meta.name %> - v<%= meta.version %> - ' + /**/
            '<%= grunt.template.today("yyyy-mm-dd") %>\n' + /**/
            '---------------------------------------------------\n' + /**/
            '[![Build Status](https://secure.travis-ci.org/maksimr/vim-jsbeautify.png)](http://travis-ci.org/maksimr/vim-jsbeautify)',
            footer: '\n[Website](http://<%=meta.website%>/)\n\n' + /**/
            'Copyright (c) <%= grunt.template.today("yyyy") %> ' + /**/
            '<%=meta.author%>; Licensed MIT'
        },
        concat: {
            dist: [{
                src: ['<banner:meta.banner>', 'doc/ru/About.*.markdown', 'doc/ru/Installation.*.markdown', 'doc/ru/Configuration.*.markdown', 'doc/ru/Usage.*.markdown', '<banner:meta.footer>'],
                dest: 'README_RUS.markdown'
            }, {
                src: ['<banner:meta.banner>', 'doc/en/About.*.markdown', 'doc/en/Installation.*.markdown', 'doc/en/Configuration.*.markdown', 'doc/en/Usage.*.markdown', '<banner:meta.footer>'],
                dest: 'README.markdown'
            }]
        },
        min: {
            dist: {
                src: ['plugin/beautify.js'],
                dest: 'plugin/beautify.min.js'
            }
        },
        test: {
            files: ['plugin/tests/*_test.js']
        },
        lint: {
            files: ['grunt.js', 'plugin/*js', '<config:test.files>']
        },
        watch: {
            files: '<config:lint.files>',
            tasks: 'test'
        },
        jshint: {
            options: {
                curly: true,
                eqeqeq: true,
                immed: true,
                latedef: true,
                newcap: true,
                noarg: true,
                sub: true,
                undef: true,
                boss: true,
                eqnull: true,
                node: true
            },
            globals: {
                exports: true,
                module: false
            }
        },
        uglify: {}
    });

    grunt.registerMultiTask('concat', 'Concatenate files.', function() {
        var _concat = function(file) {
            var files = grunt.file.expandFiles(file.src);
            //Concat specified files.
            var src = grunt.helper('concat', files, {
                separator: this.data.separator
            });
            grunt.file.write(file.dest, src);
        };

        if (Array.isArray(this.data)) {
            this.data.forEach(_concat.bind(this));
        } else {
            _concat.call(this, this.file);
        }

        // Fail task if errors were logged.
        if (this.errorCount) {
            return false;
        }

        // Otherwise, print a success message.
        grunt.log.writeln('File "' + this.file.dest + '" created.');
    });

    grunt.registerHelper('concat', function(files, options) {
        options = grunt.utils._.defaults(options || {}, {
            separator: grunt.utils.linefeed

        });
        return files ? files.map(function(filepath) {
            return grunt.task.directive(filepath, grunt.file.read);

        }).join(grunt.utils.normalizelf(options.separator)) : '';
    });


    // Default task.
    grunt.registerTask('default', 'test min');
};
