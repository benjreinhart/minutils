{toString, hasOwnProperty} = Object.prototype

ArrayProto = Array.prototype
{slice} = ArrayProto
nativeMap = ArrayProto.map
nativeReduce = ArrayProto.reduce
nativeForEach = ArrayProto.forEach

nativeBind = Function.prototype.bind

module.exports = mu = {}

##################
# Object methods #
##################

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

['Arguments', 'Date', 'Function', 'Number', 'RegExp', 'String'].forEach (name) ->
  mu["is#{name}"] = (obj) -> toString.call(obj) is "[object #{name}]"

if mu.isArguments(arguments) is false
  mu.isArguments = (obj) -> !!(obj and mu.has(obj, 'callee'))

if 'function' isnt typeof (/./)
  mu.isFunction = (obj) -> 'function' is typeof obj

mu.isBoolean = (obj) ->
  obj is true or obj is false or toString.call(obj) is '[object Boolean]'

mu.isEmpty = isEmpty = (obj) ->
  return true unless obj?
  if mu.isArray(obj) or mu.isString(obj)
    return obj.length is 0
  return false for own key of obj
  true

mu.has = (obj, key) ->
  hasOwnProperty.call(obj, key)


##################
# String Methods #
##################

mu.isBlank = (str) ->
  not /\S/.test str


#################
# Array Methods #
#################

mu.first = mu.head = (array, n = 1) ->
  return undefined unless array?
  if n is 1 then array[0] else array[0...n]

mu.last = (array, n = 1) ->
  return undefined unless array?
  len = array.length
  if n is 1 then array[len - 1] else array[(len - n)..]

mu.tail = mu.rest = (array, n = 1) ->
  if array? then array[n..]


####################
# Function methods #
####################

mu.bind = bind = (fn, obj, args...) ->
  if nativeBind and nativeBind is fn.bind
    return fn.bind obj, args...

  if mu.isFunction fn
    (args2...) -> fn.apply(obj, args.concat(args2))
  else
    (throw new TypeError)


######################
# Collection methods #
######################

mu.each = each = (coll, fn, context) ->
  return if mu.isEmpty coll

  if coll.forEach is nativeForEach
    coll.forEach fn, context
  else if mu.isArray coll
    fn.call(context, elem, i, coll) for elem, i in coll
  else
    fn.call(context, val, key, coll) for own key, val of coll

  undefined

mu.map = (coll, fn, context) ->
  return if mu.isEmpty coll

  if coll.map is nativeMap
    coll.map fn, context
  else if mu.isArray coll
    fn.call(context, elem, i, coll) for elem, i in coll
  else
    fn.call(context, val, key, coll) for own key, val of coll


nativeReduceError = ->
  new TypeError "Reduce of empty array with no initial value"

mu.reduce = (coll, fn, memo, context) ->
  coll ?= []; initial = arguments.length > 2

  if nativeReduce and coll.reduce is nativeReduce
    fn = bind(fn, context) if context?
    return if initial then coll.reduce(fn, memo) else coll.reduce fn

  return (throw nativeReduceError()) if isEmpty coll

  each coll, (val, indexOrKey, obj) ->
    if initial
      memo = fn.call context, memo, val, indexOrKey, obj
    else
      memo = val
      initial = true
  memo

mu.partition = (coll, fn, context) ->
  if mu.isArray(coll) or mu.isString(coll) or mu.isArguments(coll)
    truthy = []; falsy = []
  else
    truthy = {}; falsy = {}

  if mu.isArray truthy
    for elem, i in coll
      (if fn.call(context, elem, i, coll) then truthy else falsy).push elem
  else
    for own key, val of coll
      (if fn.call(context, val, key, coll) then truthy else falsy)[key] = val

  [truthy, falsy]
