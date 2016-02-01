/**
 * @description Runer for jsbeautify
 * support nodejs and v8 interpretator
 */

(function(contentPath, options, path) {
    "use strict";
    var global = (function() {
        return this || eval.call(null, 'this');
    }()),
        load = global.load,
        read = global.read,
        hop = Object.prototype.hasOwnProperty,
        print = null,
        hasCache = null,

        objectPrototypeToString = Object.prototype.toString,

        isFunction = function(it) {
            return objectPrototypeToString.call(it) === '[object Function]';
        },
        isUndefined = function(it) {
            return typeof it === 'undefined';
        },

        has = function(name) {
            hasCache[name] = isFunction(hasCache[name]) ? hasCache[name](global) : hasCache[name];
            return hasCache[name];
        };

    hasCache = has.cache = {};

    has.add = function(name, test, now, force) {
        if (isUndefined(hasCache[name]) || force) {
            hasCache[name] = test;
        }
        return now && has(name);
    };

    has.add('host-node', global.process && /node(\.exe||js)?$/.test(global.process.execPath));
    has.add('host-v8', isFunction(global.load) && isFunction(global.read));
    has.add('host-iojs', global.process && /iojs(\.exe)?$/.test(global.process.execPath));

    if (has('host-v8')) {
        print = global.write;
        global.window = global;
        // get rootPath
        // Need for html-beautify
        // because it require loading js-beautify and css-beautify
        global.rootPath = path.replace(/[\w-.]+.js$/,'');
    }

    if (has('host-node') || has('host-iojs')) {
        (function() {
            var fs = require('fs');

            load = function(path) {
                var context = {},
                    property;

                // if path not absolute
                // check for path beginning with / for unix systems
                // or with a second character of : for Windows C:\
                // style paths
                if (path.charAt(0) !== '/' && path.charAt(1) !== ':') {
                    path = global.process.cwd() + '/' + path; // make relative path
                }

                context = require(path);

                for (property in context) {
                    if (hop.call(context, property)) {
                        global[property] = context[property];
                    }
                }
            };

            print = process.stdout.write.bind(process.stdout);
            read = function(path) {
                return fs.readFileSync(path, 'utf-8');
            };
        }());
    }

    // execute jsbeautify
    (function(contentPath, options, path) {
        var defOps = {
            indent_size: 4,
            indent_char: ' '
        },
            content = read(contentPath);
        options = (options && JSON.parse(options)) || defOps;

        load(path);

        global.beautify = global.js_beautify || global.html_beautify || global.css_beautify;

        // XXX
        if (has('host-v8') && global.html_beautify) {
            load(global.rootPath+'beautify.js');
            load(global.rootPath+'beautify-css.js');
        }

        //FIXME(maksimrv): Hm.... Why?! only for html :|
        if (global.html_beautify) {
            print(global.beautify(content, options).replace(/\n$/g, ''));
            return;
        }

        print(global.beautify(content, options));

    }(contentPath, options, path));
}).apply(this, (typeof process === 'object' && process.argv.splice(3)) || arguments);
