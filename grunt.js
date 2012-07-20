/**
 * @param {Object} grunt The grunt configuration
 * object.
 */
module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        lint: {
            files: ['assets/javascripts/**/*.js']
        },
        /**
         * grunt-reload plugin.
         * npm install grunt-reload
         */
        reload: {
            port: 35729
        },
        /**
         * grunt-reload plugin.
         * npm install grunt-compass
         */
        compass: {
            dev: {
                src: 'assets/sass',
                dest: 'public/stylesheets',
                linecomments: true,
                forcecompile: true,
                debugsass: true,
                images: 'public/images',
                relativeassets: true
            },
            prod: {
                src: 'assets/sass',
                dest: 'public/stylesheets',
                outputstyle: 'compressed',
                linecomments: false,
                forcecompile: true,
                debugsass: false,
                images: 'public/images',
                relativeassets: true
            }
        },
        concat: {
            dist: {
                src: ['<file_strip_banner:out/FILE_NAME.js>'],
                dest: 'dist/FILE_NAME.js'
            }
        },
        min: {
            dist: {
                src: ['<config:concat.dist.dest>'],
                dest: 'dist/FILE_NAME.min.js'
            }
        },
        watch: {
            files: ['<config:lint.files>', 'assets/sass/**/*.scss'],
            tasks: 'compass:dev reload'
        },
        uglify: {}
    });

    // Load external plugins
    grunt.loadNpmTasks('grunt-reload');
    grunt.loadNpmTasks('grunt-compass');

    // Default task.
    grunt.registerTask('default', 'min');
};
