/**
 * Project configuration.
 * @param {Object} grunt The global object.
 *
 * 2012-06-30
 */

module.exports = function(grunt) {

    grunt.initConfig({
        pkg: {
            name: 'beautify'
        },
        min: {
            dist: {
                src: ['plugin/<%= pkg.name %>.js'],
                dest: 'plugin/<%= pkg.name %>.min.js'
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
