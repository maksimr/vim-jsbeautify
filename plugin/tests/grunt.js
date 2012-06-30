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
                src: ['../<%= pkg.name %>.js'],
                dest: '../<%= pkg.name %>.min.js'
            }
        },
        test: {
            files: ['*_test.js']
        },
        lint: {
            files: ['grunt.js', '../*.js', '**/*.js']
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
