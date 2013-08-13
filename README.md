# minutils

Minimal utility methods for node and the browser.

## How does one acquire this library?

Node: `npm install minutils`. `require 'minutils'`

Browser: Copy either minutils.js or minutils.min.js (in the root of this repo) into your project. Inlcude on page. Then access it at `window.mu`.

## Why not use underscore?

Because I don't necessarily need to bring in something the size of underscore in small projects. Because there may be methods in this library that aren't in underscore (or other libraries). Because it's fun. Because.

## API

#### Utilities

* [extend](#extend)
* [defaults](#defaults)
* [clone](#clone)
* [isObject](#isObject)
* [isArray](#isArray)
* [isString](#isString)
* [isNumber](#isNumber)
* [isFunction](#isFunction)
* [isArguments](#isArguments)
* [isBoolean](#isBoolean)
* [isRegExp](#isRegExp)
* [isDate](#isDate)
* [isEmpty](#isEmpty)
* [has](#has)

#### Strings

* [isBlank](#isBlank)

#### Arrays

* [first](#first), [head](#head)
* [last](#last)
* [rest](#rest), [tail](#tail)

#### Functions

* [bind](#bind)

#### Collections

* [each](#each)
* [map](#map)
* [reduce](#reduce)
* [partition](#partition)


### Utilities

<a name="extend" />
##### extend(destination, objects*)

Copies all properties from all `objects` into `destination`, replacing any existing properties of the same name.

```javascript
var person = {name: 'Richard'}
extend(person, {name: 'Lisa'}, {age: 124}, {alive: false})

console.log(person) // {name: 'Lisa', age: 124, alive: false}
```

<a name="defaults" />
##### defaults(destination, objects*)

Takes all properties from `objects` and copies them in to `destination` *only* if the properties are `undefined` in `destination`

```javascript
person = {name: 'Richard'}
defaults(person, {name: 'Lisa'}, {age: 124}, {alive: false})

console.log(person) // {name: 'Richard', age: 124, alive: false}
```

<a name="clone" />
##### clone(object)

Returns a shallow copy of `object`.

```javascript
clone({attr: true}) // {attr: true}
```

<a name="isObject" />
##### isObject(object)

Determines whether `object` is an Object.

```javascript
isObject([]) // true
isObject({}) // true
isObject('') // false
```

<a name="isArray" />
##### isArray(object)

Is the native `isArray` if exists. Determines whether an object is a real array.

```javascript
isArray(['first element']) // true
isArray({'0': 'first element', length: 1}) // false
isArray(arguments) // false
```
<a name="isString" />
##### isString(object)

Determines whether `object` is a String.

```javascript
isString('s') // true
isString({'0': 's'}) // false
```

<a name="isNumber" />
##### isNumber(object)

Determines whether `object` is a Number.

```javascript
isNumber(10) // true
isNumber('10') // false
```

<a name="isFunction" />
##### isFunction(object)

Determines whether `object` is a Function.

```javascript
isFunction(function(){}) // true
isFunction({}) // false
```

<a name="isArguments" />
##### isArguments(object)

Determines whether `object` is the `arguments` object.

```javascript
(function(){
  isArguments(arguments) // true
  isArguments({}) //false
})()
```

<a name="isBoolean" />
##### isBoolean

Determines whether `object` is a Boolean.

```javascript
isBoolean(true) // true
isBoolean(false) // true
isBoolean(true) // false
```

<a name="isRegExp" />
##### isRegExp(object)

Determines whether `object` is a RegExp.

```javascript
isRegExp(//) // true
isRegExp(10) // false
```

<a name="isDate" />
##### isDate(object)

Determines whether `object` is a Date.

```javascript
isDate(new Date) // true
isDate(10) // false
```

<a name="isEmpty" />
##### isEmpty(object)

Determines whether `object` has any values.

```javascript
isEmpty(null) // true
isEmpty(undefined) // true
isEmpty({}) // true
isEmpty([]) // true
isEmpty('') // true

isEmpty({key: 'val'}) // false
isEmpty([1]) // false
isEmpty('string') // false
```

<a name="has" />
##### has(object, key)

Determines whether `object` has own `key`.

```javascript
has({toString: ''}, 'toString') // true
has({}, 'toString') // false
```

### Strings

<a name="isBlank" />
##### isBlank(string)

Is `true` if a `string` contains only whitespace characters.

```javascript
isBlank('') // true
isBlank('         ') // true
isBlank('\n\t\r \t \t \n \n  \r') // true

isBlank('      c   ') // false
```

### Arrays

<a name="first" />
<a name="head" />
##### first(array, n = 1)

Alias: `head`

Returns the first `n` elements of array or the first element if `n` is 1 (the default).

```javascript
first([1, 2, 3, 4, 5]) // 1
first([1, 2, 3, 4, 5], 3) // [1, 2, 3]
```

<a name="last" />
##### last(array, n = 1)

Returns the last `n` elements of the array or the last element of the array if `n` is 1 (the default).

```javascript
last([1, 2, 3, 4, 5]) // 5
last([1, 2, 3, 4, 5], 3) // [3, 4, 5]
```

<a name="rest" />
<a name="tail" />
##### rest(array, n = 1)

Alias: `tail`

Returns the rest of the array starting at index `n` (default is 1).

```javascript
rest([1, 2, 3, 4, 5]) // [2, 3, 4, 5]
rest([1, 2, 3, 4, 5], 3) // [4, 5]
```

### Functions

<a name="bind" />
##### bind(fn, object[, defaults*])

Returns a function which will always call `fn` with a `this` value of `object`. Optionally accepts default arguments and will return a partially applied function.

```javascript
var obj = {name: 'the dude!'}

fn = function(greeting, greeting2){
  return greeting + ' ' + greeting2 + ' ' + this.name
}

fn('hello', 'hi') // 'hello hi '

bind(fn, obj)('hello', 'hi') // 'hello hi the dude!'
bind(fn, obj, 'hello')('hi') // 'hello hi the dude!'
bind(fn, obj, 'hello', 'hi')() // 'hello hi the dude!'
```


### Collections

<a name="each" />
##### each(coll, fn[, context])

Applies `fn` to each element in `coll`. Returns `undefined`. `context` is `fn`'s `this` value.

If `coll` is an array, `fn` will be called with `(element, index, coll)`. If `coll` is a JavaScript object, then `fn` will be called with `(value, key, coll)`.

```javascript
each([1, 2, 3], console.log, console)
/*
  1 0 [1, 2, 3]
  2 1 [1, 2, 3]
  3 2 [1, 2, 3]
*/
each({one: 1, two: 2, three: 3}, console.log, console)
/*
  1 'one' {one: 1, two: 2, three: 3}
  2 'two' {one: 1, two: 2, three: 3}
  3 'three' {one: 1, two: 2, three: 3}
*/
```

<a name="map" />
##### map(coll, fn[, context])

Returns an array of the return values of applying `fn` to each element in `coll`.

If `coll` is an array, `fn` will be called with `(element, index, coll)`. If `coll` is a JavaScript object, then `fn` will be called with `(value, key, coll)`.

```javascript
var square = function(n) {return n*n}
map([2, 4], square) // [4, 16]
map({two: 2, four: 4}, square) // [4, 16]
```

<a name="reduce" />
##### reduce(coll, fn[, memo[, context]])

Returns a single value from a list of values.

If `coll` is an array, `fn` will be called with `(memo, element, index, coll)`. If `coll` is a JavaScript object, then `fn` will be called with `(memo, value, key, coll)`.

```javascript
var sum = function(x, y){return x+y}
reduce([1, 2, 3], sum, 0) // 6
reduce({'one': 1, 'two': 2, 'three': 3}, sum, 0) // 6
```

<a name="partition" />
##### partition(coll, fn[, context])

Returns an array containing two arrays. The first array contains all the values which the `fn` evalutates as truthy, the second array contains the rest.

If `coll` is an array, `fn` will be called with `(element, index, coll)`. If `coll` is a JavaScript object, then `fn` will be called with `(value, key, coll)`.

```javascript
var isEven = function(n) {return n % 2 == 0};
partition([1, 2, 3, 4, 5], isEven) // [[2, 4], [1, 3, 5]]

console.log(partition({'one': 1, 'two': 2, 'three': 3}, isEven))
/*
  [
    [['two', 2]],
    [['one', 1], ['three', 3]]
  ]
*/
```

## License

(The MIT License)

Copyright (c) 2013 Ben Reinhart

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.