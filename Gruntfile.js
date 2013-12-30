/**
 * Project configuration.
 * @param {Object} grunt The global object.
 *
 * 2012-06-30
 */

module.exports = function(grunt) {

    grunt.initConfig({
        urchin: {
            args: ['-f', 'test']
        },
        uglify: {
            options: {
                compress: false,
                mangle: false
            },
            dist: {
                files: {
                    'plugin/beautify.min.js': ['plugin/beautify.js']
                }
            }
        },
        nodeunit: {
            all: ['test/javascript/*_test.js'],
            node: ['test/javascript/beautify_test.js']
        },
        lint: {
            files: ['grunt.js', 'plugin/*js', '<config:test.files>']
        },
        watch: {
            vim: {
                files: ['plugin/*.vim', 'test/vim/**/*'],
                tasks: 'urchin'
            },
            javascript: {
                files: ['plugin/*.js', 'test/javascript/**/*.js'],
                tasks: 'test'
            }
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
        }
    });
    grunt.registerTask('urchin', 'Urchin is a test framework for shell. It currently supports bash on GNU/Linux and Mac.', function() {
        var data = grunt.config('urchin');
        var util = grunt.util;
        var args = data.args;
        var log = grunt.log;
        var done = this.async();

        util.spawn({
            cmd: './urchin',
            args: args
        }, function(err, result) {
            err = err || result.stdout.match(/\n[^0]\d* tests failed/g);

            if (!err) {
                log.writeln(result);
                return done(null);
            }

            // error handling
            log.writeln(result);
            done(false);
        });
    });

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-nodeunit');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    // Default task.
    grunt.registerTask('test', ['nodeunit:all', 'urchin']);
    grunt.registerTask('default', ['nodeunit:all', 'urchin']);
    grunt.registerTask('build', ['jshint', 'nodeunit:all', 'urchin', 'uglify']);
};
