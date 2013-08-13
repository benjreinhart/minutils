// Generated by CommonJS Everywhere 0.9.2
(function (global) {
  function require(file, parentModule) {
    if ({}.hasOwnProperty.call(require.cache, file))
      return require.cache[file];
    var resolved = require.resolve(file);
    if (!resolved)
      throw new Error('Failed to resolve module ' + file);
    var module$ = {
        id: file,
        require: require,
        filename: file,
        exports: {},
        loaded: false,
        parent: parentModule,
        children: []
      };
    if (parentModule)
      parentModule.children.push(module$);
    var dirname = file.slice(0, file.lastIndexOf('/') + 1);
    require.cache[file] = module$.exports;
    resolved.call(module$.exports, module$, module$.exports, dirname, file);
    module$.loaded = true;
    return require.cache[file] = module$.exports;
  }
  require.modules = {};
  require.cache = {};
  require.resolve = function (file) {
    return {}.hasOwnProperty.call(require.modules, file) ? require.modules[file] : void 0;
  };
  require.define = function (file, fn) {
    require.modules[file] = fn;
  };
  var process = function () {
      var cwd = '/';
      return {
        title: 'browser',
        version: 'v0.8.25',
        browser: true,
        env: {},
        argv: [],
        nextTick: global.setImmediate || function (fn) {
          setTimeout(fn, 0);
        },
        cwd: function () {
          return cwd;
        },
        chdir: function (dir) {
          cwd = dir;
        }
      };
    }();
  require.define('/lib/index.js', function (module, exports, __dirname, __filename) {
    void function () {
      var ArrayProto, cache$, each, hasOwnProperty, isEmpty, mu, nativeForEach, nativeMap, nativeReduce, nativeReduceError, slice, toString;
      ArrayProto = Array.prototype;
      cache$ = Object.prototype;
      toString = cache$.toString;
      hasOwnProperty = cache$.hasOwnProperty;
      slice = ArrayProto.slice;
      nativeMap = ArrayProto.map;
      nativeReduce = ArrayProto.reduce;
      nativeForEach = ArrayProto.forEach;
      module.exports = mu = {};
      mu.extend = function (obj) {
        slice.call(arguments, 1).forEach(function (source) {
          var key;
          for (key in source) {
            if (!isOwn$(source, key))
              continue;
            obj[key] = source[key];
          }
        });
        return obj;
      };
      mu.defaults = function (obj) {
        slice.call(arguments, 1).forEach(function (source) {
          var key;
          for (key in source) {
            if (!isOwn$(source, key))
              continue;
            if (!(null != obj[key]))
              obj[key] = source[key];
          }
        });
        return obj;
      };
      mu.clone = function (obj) {
        return mu.extend({}, obj);
      };
      mu.isArray = Array.isArray || function (obj) {
        return toString.call(obj) === '[object Array]';
      };
      mu.isObject = function (obj) {
        return obj === Object(obj);
      };
      (function () {
        return [
          'Arguments',
          'Date',
          'Function',
          'Number',
          'RegExp',
          'String'
        ].forEach(function (name) {
          return mu['is' + name] = function (obj) {
            return toString.call(obj) === '[object ' + name + ']';
          };
        });
      }());
      if (mu.isArguments(arguments) === false)
        mu.isArguments = function (obj) {
          return !!(obj && mu.has(obj, 'callee'));
        };
      if ('function' !== typeof /./)
        mu.isFunction = function (obj) {
          return 'function' === typeof obj;
        };
      mu.isBoolean = function (obj) {
        return obj === true || obj === false || toString.call(obj) === '[object Boolean]';
      };
      mu.isEmpty = isEmpty = function (obj) {
        var key;
        if (!(null != obj))
          return true;
        if (mu.isArray(obj) || mu.isString(obj))
          return obj.length === 0;
        for (key in obj) {
          if (!isOwn$(obj, key))
            continue;
          return false;
        }
        return true;
      };
      mu.has = function (obj, key) {
        return hasOwnProperty.call(obj, key);
      };
      mu.isBlank = function (str) {
        return !/\S/.test(str);
      };
      mu.first = mu.head = function (array, n) {
        if (null == n)
          n = 1;
        if (!(null != array))
          return;
        if (n === 1) {
          return array[0];
        } else {
          return array.slice(0, n);
        }
      };
      mu.last = function (array, n) {
        var len;
        if (null == n)
          n = 1;
        if (!(null != array))
          return;
        len = array.length;
        if (n === 1) {
          return array[len - 1];
        } else {
          return array.slice(len - n);
        }
      };
      mu.tail = mu.rest = function (array, n) {
        if (null == n)
          n = 1;
        if (null != array)
          return array.slice(n);
      };
      mu.each = each = function (coll, fn, context) {
        var elem, i, key, val;
        if (mu.isEmpty(coll))
          return;
        if (coll.forEach === nativeForEach) {
          coll.forEach(fn, context);
        } else if (mu.isArray(coll)) {
          for (var i$ = 0, length$ = coll.length; i$ < length$; ++i$) {
            elem = coll[i$];
            i = i$;
            fn.call(context, elem, i, coll);
          }
        } else {
          for (key in coll) {
            if (!isOwn$(coll, key))
              continue;
            val = coll[key];
            fn.call(context, val, key, coll);
          }
        }
      };
      mu.map = function (coll, fn, context) {
        if (mu.isEmpty(coll))
          return;
        if (coll.map === nativeMap) {
          return coll.map(fn, context);
        } else if (mu.isArray(coll)) {
          return function (accum$) {
            var elem, i;
            for (var i$ = 0, length$ = coll.length; i$ < length$; ++i$) {
              elem = coll[i$];
              i = i$;
              accum$.push(fn.call(context, elem, i, coll));
            }
            return accum$;
          }.call(this, []);
        } else {
          return function (accum$) {
            var key, val;
            for (key in coll) {
              if (!isOwn$(coll, key))
                continue;
              val = coll[key];
              accum$.push(fn.call(context, val, key, coll));
            }
            return accum$;
          }.call(this, []);
        }
      };
      nativeReduceError = function () {
        return new TypeError('Reduce of empty array with no initial value');
      };
      mu.reduce = function (coll, fn, memo, context) {
        var initial;
        if (null != coll)
          coll;
        else
          coll = [];
        initial = arguments.length > 2;
        if (nativeReduce && coll.reduce === nativeReduce) {
          if (null != context)
            fn = fn.bind(context);
          return initial ? coll.reduce(fn, memo) : coll.reduce(fn);
        }
        if (isEmpty(coll))
          return function () {
            throw nativeReduceError();
          }();
        each(coll, function (val, indexOrKey, obj) {
          if (initial) {
            return memo = fn.call(context, memo, val, indexOrKey, obj);
          } else {
            memo = val;
            return initial = true;
          }
        });
        return memo;
      };
      mu.partition = function (coll, fn, context) {
        var cache$1, elem, falsy, i, key, result, truthy, val;
        cache$1 = result = [
          [],
          []
        ];
        truthy = cache$1[0];
        falsy = cache$1[1];
        if (mu.isEmpty(coll))
          return result;
        if (mu.isArray(coll)) {
          for (var i$ = 0, length$ = coll.length; i$ < length$; ++i$) {
            elem = coll[i$];
            i = i$;
            (fn.call(context, elem, i, coll) ? truthy : falsy).push(elem);
          }
        } else {
          for (key in coll) {
            if (!isOwn$(coll, key))
              continue;
            val = coll[key];
            (fn.call(context, val, key, coll) ? truthy : falsy).push([
              key,
              val
            ]);
          }
        }
        return result;
      };
      function isOwn$(o, p) {
        return {}.hasOwnProperty.call(o, p);
      }
    }.call(this);
  });
  global.mu = require('/lib/index.js');
}.call(this, this));