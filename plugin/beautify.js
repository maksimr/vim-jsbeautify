/**
 * @description Runer for jsbeautify
 * support nodejs and v8 interpretator
 */

(function(contentPath, options, path) {
    "use strict";
    var
    global = (function() {
        return this || eval.call(null, 'this');
    }()),
        load = global.load,
        read = global.read,
        print = global.print,
        hasCache = null,

        objectPrototypeToString = Object.prototype.toString,

        isFunction = function(it) {
            return objectPrototypeToString.call(it) === '[object Function]';
        },
        isUndefined = function(it) {
            return typeof it === 'undefined';
        },
        isObject = function(it) {
            return objectPrototypeToString.call(it) === '[object Object]';
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

    has.add('host-node', isObject(global.process) && /node(\.exe||js)?$/.test(global.process.execPath));
    has.add('host-v8', isFunction(global.load) && isFunction(global.read));

    if (has('host-node')) {
      (function () {
        var fs = require('fs'),
            vm = require('vm');

        load = function(path) {
                var context = {},
                data = read(path);

            vm.runInNewContext(data, context, path);
            global.js_beautify = context.js_beautify;
        };

        print = global.console.log;
        read = function (path) {
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
        print(global.js_beautify(content, options));

    }(contentPath, options, path));
}).apply(this, (typeof process === 'object' && process.argv.splice(3)) || arguments);
