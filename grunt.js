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
        min: {
            dist: {
                src: ['plugin/beautify.js'],
                dest: 'plugin/beautify.min.js'
            }
        },
        test: {
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
                files: ['plugin/*.js', '<config:test.files>'],
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
        var utils = grunt.utils;
        var verbose = grunt.verbose;
        var args = data.args;
        var log = grunt.log;
        var done = this.async();

        utils.spawn({
            cmd: 'urchin',
            args: args
        }, function(err, result, code) {
            if (!err) {
                result.split('\n').forEach(log.writeln, log);
                return done(null);
            }

            // error handling
            verbose.or.writeln();
            log.write('Running urchin...').error();
            result.split('\n').forEach(log.error, log);
            done(code);
        });
    });

    // Default task.
    grunt.registerTask('default', 'test urchin');
    grunt.registerTask('build', 'lint urchin test min');
};
