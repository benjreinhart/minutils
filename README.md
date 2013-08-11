# minutils

Minimal utility methods for node and the browser.

## How does one acquire this library?

Node: `npm install minutils`

Browser: Copy either minutils.js or minutils.min.js (in the root of this repo) into your project. Inlcude on page. Then access it at `window.mu`.

## Why not use underscore?

Because I don't necessarily need to bring in something the size of underscore in small projects. Because there may be methods in this library that aren't in underscore (or other libraries). Because it's fun. Because.

## API

* [extend](#extend)
* [defaults](#defaults)
* [clone](#clone)
* [isObject](#isObject)
* [isArray](#isArray)

< name="extend" />
##### extend(destination, objects*)

Copies all properties from all `objects` into `destination`, replacing any existing properties of the same name.

```javascript
var person = {name: 'RICHARD'}
extend(person, {age: 124}, {alive: false})

console.log(person) // {name: 'RICHARD', age: 124, alive: false}
```

< name="defaults" />
##### defaults(destination, objects*)

Takes all properties from `objects` and copies them in to `destination` *only* if the properties are `undefined` in `destination`

```javascript
person = {name: 'Richard'}
defaults(person, {name: 'Lisa'}, {age: 124}, {alive: false})

console.log(person) // {name: 'Richard', age: 124, alive: false}
```

< name="clone" />
##### clone(object)

Returns a shallow copy of `object`.

```javascript
clone({attr: true}) // {attr: true}
```

< name="isObject" />
##### isObject(object)

Determines whether `object` is an Object.

```javascript
isObject([]) // true
isObject({}) // true
isObject('') // false
```

< name="isArray" />
##### isArray(object)

Is the native `isArray` if exists. Determines whether an object is a real array.

```javascript
isArray(['first element']) // true
isArray({'0': 'first element', length: 1}) // false
isArray(arguments) // false
```
< name="isString" />
##### isString(object)

Determines whether `object` is a String.

```javascript
isString('s') // true
isString({'0': 's'}) // false
```

< name="isNumber" />
##### isNumber(object)

Determines whether `object` is a Number.

```javascript
isNumber(10) // true
isNumber('10') // false
```

< name="isFunction" />
##### isFunction(object)

Determines whether `object` is a Function.

```javascript
isFunction(function(){}) // true
isFunction({}) // false
```

< name="isArguments" />
##### isArguments(object)

Determines whether `object` is the `arguments` object.

```javascript
(function(){
  isArguments(arguments) // true
  isArguments({}) //false
})()
```

< name="isBoolean" />
##### isBoolean

Determines whether `object` is a Boolean.

```javascript
isBoolean(true) // true
isBoolean(false) // true
isBoolean(true) // false
```

< name="isDate" />
##### isDate(object)

Determines whether `object` is a Date.

```javascript
isDate(new Date) // true
isDate(10) // false
```

< name="isEmpty" />
##### isEmpty(object)

Determines whether the object has any values.

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

< name="first" />
< name="head" />
##### first(array, n = 1)

Alias: `head`

Returns the first `n` elements of array or the first element if `n` is 1 (the default).

```javascript
first([1, 2, 3, 4, 5]) // 1
first([1, 2, 3, 4, 5], 3) // [1, 2, 3]
```

< name="last" />
##### last(array, n = 1)

Returns the last `n` elements of teh array of the last element of the array if `n` is 1 (the default).

```javascript
last([1, 2, 3, 4, 5]) // 5
last([1, 2, 3, 4, 5], 3) // [3, 4, 5]
```

< name="rest" />
< name="tail" />
##### rest(array, n = 1)

Alias: `tail`

Returns the rest of the array starting at index `n` (default is 1).

```javascript
rest([1, 2, 3, 4, 5]) // [2, 3, 4, 5]
rest([1, 2, 3, 4, 5], 3) // [4, 5]
```
< name="partition" />
##### partition(array, fn)

Returns an array containing two arrays. The first array contains all the values which the `fn` evalutates as truthy, the second array contains the rest.

```javascript
var isEven = function(n) {return n % 2 == 0};
partition([1, 2, 3, 4, 5], isEven) // [[2, 4], [1, 3, 5]]
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