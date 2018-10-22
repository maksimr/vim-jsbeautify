module.exports = function(grunt) {
  grunt.initConfig({
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
        files: ['plugin/*.vim', 't/**/*'],
        tasks: 'rake test'
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

  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  // Default task.
  grunt.registerTask('test', ['nodeunit:all']);
  grunt.registerTask('default', ['nodeunit:all']);
  grunt.registerTask('build', ['jshint', 'nodeunit:all', 'uglify']);
};
