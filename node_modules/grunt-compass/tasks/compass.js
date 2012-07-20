module.exports = function( grunt ) {

    // Create a new multi task.
    grunt.registerMultiTask( 'compass', 'This triggers the `compass compile` command.', function() {

        // Tell grunt this task is asynchronous.
        var done = this.async(),
            exec = require('child_process').exec,
            command = "compass compile",
            src = grunt.template.process(this.data.src),
            dest = grunt.template.process(this.data.dest),
            images = this.data.images,
            outputstyle = this.data.outputstyle,
            linecomments = this.data.linecomments,
            forcecompile = this.data.forcecompile,
            debugsass = this.data.debugsass,
            relativeassets = this.data.relativeassets,
            libRequire = this.data.require;

        if ( src !== undefined && dest !== undefined ) {
            command += ' --sass-dir="' + src + '" --css-dir="' + dest + '"';
        }

        if ( images !== undefined ) {
            command += ' --images-dir="' + images + '"';
        }

        if ( debugsass !== undefined ) {
            if ( debugsass === true ) {
                command += ' --debug-info';
            }
        }

        if ( relativeassets !== undefined ) {
            if ( relativeassets === true ) {
                command += ' --relative-assets';
            }
        }

        if ( outputstyle !== undefined ) {
            command += ' --output-style ' + outputstyle;
        }

        if ( linecomments === false ) {
            command += ' --no-line-comments';
        }

        if(libRequire !== undefined){
            command += ' --require '+ libRequire;
        }

        if ( forcecompile === true ) {
            command += ' --force';
        }

        function puts( error, stdout, stderr ) {

            grunt.log.write( '\n\nCOMPASS output:\n' );
            grunt.log.write( stdout );
            /* grunt.log.error( stderr );
             * compass sends falsy error message to stderr... real sass/compass errors come in through the "error" variable.
             */

            if ( error !== null ) {
                grunt.log.error( error );
                done(false);
            }
            else
            {
                done(true);
            }
        }

        exec( command, puts );
        grunt.log.write( '`' + command + '` was initiated.' );
    });
};
