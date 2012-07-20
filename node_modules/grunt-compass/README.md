# grunt-compass

This is a custom grunt.js multitask aka [gruntplugin](http://jsfiddle.net/cowboy/qzRjD/show/) that executes `compass compile` on the command line for you and prints the COMPASS output to `grunt.log.write()`.

## Dependencies

You need to have [node.js](http://nodejs.org/), [grunt.js](https://github.com/cowboy/grunt), [Ruby](http://www.ruby-lang.org/), [SASS](http://sass-lang.com/) and [Compass](http://compass-style.org/) installed for this to work.

## Installation & Options

1. Install this grunt plugin next to your project's grunt.js gruntfile with: `npm install grunt-compass`.
2. Call `grunt.loadNpmTasks('grunt-compass')` in your gruntfile.
3. Configure `grunt watch` to watch your scss files and call the task(s).
	e.g.:

	```javascript
	watch: {
	    files: ['assets/scss/*.scss'],
	    tasks: ['compass:dev', 'compass:prod']
	}
	```

4. Setup your SASS and CSS paths

	```javascript
    src: 'assets/scss',
    dest: 'assets/css'
	```

	`src` is the folder with sass or scss files and `dest` is the folder where the css files will be placed.

5. You can set your custom output style like this:

    ```javascript
    outputstyle: 'compressed'
    ```
6. You can disable line comments like this:

    ```javascript
    linecomments: false
    ```
7. If you have multiple compass tasks and you want to force compass compilation you can do this:

    ```javascript
    forcecompile: true
    ```
8. You can require a given ruby library before running commands like this:

    ```javascript
    require: 'animate-sass mylib'
    ```

9. You can add the `--debug-info` option for use with [FireSass](https://addons.mozilla.org/en-US/firefox/addon/firesass-for-firebug/) like so:

    ```javascript
    debugsass: true
    ```

10. You can set the relative assets to `true` and set an image path for Compass spriting feature:

    ```javascript
    images: '/path/to/images',
    relativeassets: true
    ```

11. Run "grunt watch" and change some SASS files :)

# An Example Setup

```javascript
compass: {
    dev: {
        src: 'assets/scss',
        dest: 'assets/dev/css',
        linecomments: true,
        forcecompile: true,
        require: 'animate-sass mylib',
        debugsass: true,
        images: '/path/to/images',
        relativeassets: true
    },
    prod: {
        src: 'assets/scss',
        dest: 'assets/prod/css',
        outputstyle: 'compressed',
        linecomments: false,
        forcecompile: true,
        require: 'animate-sass mylib',
        debugsass: false,
        images: '/path/to/images',
        relativeassets: true
    }
}
```

# Real World Examples

* [krzysu](https://github.com/krzysu) posted a Gist with his `compass compile` configuration [over here](https://gist.github.com/2917330).
* [javiervd](https://github.com/javiervd) kindly shares his grunt.js setup [over here](https://gist.github.com/2941501).

# Changelog

v0.2.13: Added `grunt.template.process()` function to process `src` and `dest` paths. Suggested by @[necolas](https://github.com/necolas) in issue #9.

v0.2.12: The option to set the image path for spriting and the relativeassets to true have been added by @[gcpantazis](https://github.com/gcpantazis).

v0.2.11: @[gcpantazis](https://github.com/gcpantazis) added the option to set the `--debug-info` flag for Sass, useful for integration with the FireSass debugger.

v0.2.10: Added 'gruntplugin' as a keyword in the package.json to get listed [here](http://jsfiddle.net/cowboy/qzRjD/show/).

v0.2.9: Ability to require a given ruby lib before running commands. Added by @[FGRibreau](https://github.com/FGRibreau).

v0.2.8: Added an option to force compilation of SASS files via the `--force` option.

----

# LICENSE MIT

Copyright (c) 2012 Kahlil Lechelt

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
