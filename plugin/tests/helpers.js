(function(global) {
    var defaultPatter = /\$\{([^\}]+)\}/g,
        objectPrototypeToString = Object.prototype.toString,
        print = function(tmpl) {
            var args = [].slice.call(arguments, 1);
            return tmpl.replace(defaultPatter, function(_, k) {
                return JSON.stringify(args[k]);
            });
        },
        /**
         * @param {Any} it any type
         * @return {Boolea} if type of it is object then return true
         */
        isObject = function(it) {
            return objectPrototypeToString.call(it) === '[object Object]';
        },
        /**
         * @description Add properties to dest object from source object
         * @private
         *
         * @param {Object} dest destination object
         * @param {Object} source object from which will be copied properties
         * @param {[Function]} copyFunc function which will be called every time a property is copied
         * @return {Object} return destination object
         */
        _mixin = function(dest, source, copyFunc) {
            var name, s, i, empty = {};
            for (name in source) {
                s = source[name];
                if (!(name in dest) || (dest[name] !== s && (!(name in empty) || empty[name] !== s))) {
                    dest[name] = copyFunc ? copyFunc(s) : s;
                }
            }
            return dest;
        },
        /**
         * @param {Object|Any} dest destination object
         * @param {Object...} sources source object. All subsequent arguments should be sources objects (subsequent from left to right)
         * @return {Object}
         */
        mixin = function(dest, sources) {
            var i, l, _dest = isObject(dest) ? dest : {};

            for (i = 1, l = arguments.length; i < l; i++) {
                _mixin(_dest, arguments[i]);
            }

            return _dest;
        };

        module.exports = {
            print: print,
            mixin: mixin
        };
}(this));
