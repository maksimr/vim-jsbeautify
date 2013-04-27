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
            files: ['test/javascript/*_test.js']
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
        var verbose = grunt.verbose;
        var args = data.args;
        var log = grunt.log;
        var done = this.async();

        util.spawn({
            cmd: './urchin',
            args: args
        }, function(err, result) {
            err = err || result.stdout.indexOf('0 tests failed') === -1;

            if (!err) {
                log.writeln(result);
                return done(result);
            }

            // error handling
            verbose.or.writeln();
            log.write('Running urchin...').error();
            log.error(result);
            done(false);
        });
    });

    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-nodeunit');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    // Default task.
    grunt.registerTask('test', ['nodeunit', 'urchin']);
    grunt.registerTask('default', ['nodeunit', 'urchin']);
    grunt.registerTask('build', ['jshint', 'urchin', 'nodeunit', 'uglify']);
};
