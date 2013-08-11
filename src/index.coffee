{slice} = Array.prototype
{toString, hasOwnProperty} = Object.prototype

module.exports = mu = {}

mu.extend = (obj) ->
  slice.call(arguments, 1).forEach (source) ->
    for own key of source
      obj[key] = source[key]
    undefined
  obj

mu.defaults = (obj) ->
  slice.call(arguments, 1).forEach (source) ->
    for own key of source
      unless obj[key]?
        obj[key] = source[key]
    undefined
  obj

mu.clone = (obj) ->
  mu.extend {}, obj

mu.isArray = Array.isArray or (obj) ->
  toString.call(obj) is '[object Array]'

mu.isObject = (obj) ->
  obj is Object(obj)

do ->
  ['Arguments', 'Date', 'Function', 'Number', 'RegExp', 'String'].forEach (name) ->
    mu["is#{name}"] = (obj) -> toString.call(obj) is "[object #{name}]"

if mu.isArguments(arguments) is false
  mu.isArguments = (obj) -> !!(obj and mu.has(obj, 'callee'))

if 'function' isnt typeof (/./)
  mu.isFunction = (obj) -> 'function' is typeof obj

mu.isBoolean = (obj) ->
  obj is true or obj is false or toString.call(obj) is '[object Boolean]'

mu.isEmpty = (obj) ->
  return true unless obj?
  if mu.isArray(obj) or mu.isString(obj)
    return obj.length is 0
  return false for own key of obj
  true

mu.has = (obj, key) ->
  hasOwnProperty.call(obj, key)

mu.first = mu.head = (array, n = 1) ->
  return undefined unless array?
  if n is 1 then array[0] else array[0...n]

mu.last = (array, n = 1) ->
  return undefined unless array?
  len = array.length
  if n is 1 then array[len - 1] else array[(len - n)..]

mu.tail = mu.rest = (array, n = 1) ->
  if array? then array[n..]


######################
# Collection methods #
######################

mu.partition = (coll, fn) ->
  [truthy, falsy] = (result = [[], []])
  return result if mu.isEmpty coll

  if mu.isArray coll
    for obj in coll
      (if fn(obj) then truthy else falsy).push obj
  else
    for own key, val of coll
      (if fn(key, val) then truthy else falsy).push [key, val]

  result


