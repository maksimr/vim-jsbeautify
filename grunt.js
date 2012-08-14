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
            dist: {
                src: ['<banner:meta.banner>', 'doc/About.*.markdown', 'doc/Installation.*.markdown', 'doc/Configuration.*.markdown', 'doc/Usage.*.markdown', '<banner:meta.footer>'],
                dest: 'README.markdown'
            }
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

    // Default task.
    grunt.registerTask('default', 'test min');
};
