sinon = require 'sinon'
minutils = require '../'
{expect} = require 'chai'

describe 'minutils', ->

  describe 'Objects', ->
    describe '#extend', ->
      {extend} = minutils

      it 'copies objects into the destination object', ->
        person = {name: 'Richard'}
        extend person, {name: 'Lisa'}, {age: 124}, {alive: false}

        expect(person).to.eql
          age: 124
          name: 'Lisa'
          alive: false

      it 'returns the destination object if no other arguments were passed', ->
        person = {name: 'Richard'}
        expect(extend person).to.eql {name: 'Richard'}

    describe '#defaults', ->
      {defaults} = minutils

      it 'fills in any undefined values in the destination object', ->
        person = {name: 'Richard'}
        defaults person, {name: 'Lisa'}, {age: 124}, {alive: false}

        expect(person).to.eql
          age: 124
          name: 'Richard'
          alive: false

      it 'returns the destination object if no other arguments were passed', ->
        person = {name: 'Richard'}
        expect(defaults person).to.eql {name: 'Richard'}

    describe '#clone', ->
      {clone} = minutils

      it 'shallow copies the argument', ->
        jobs = [{company: 'groupon'}, {company: 'US government'}]
        person = {name: 'john', jobs: jobs}

        clonedPerson = clone person

        expect(clonedPerson == person).to.be.false
        expect(clonedPerson.jobs == person.jobs).to.be.true
        expect(clonedPerson).to.eql person

    describe '#isArray', ->
      {isArray} = minutils

      it 'is native `isArray` when it exists', ->
        if minutils.isFunction Array.isArray
          expect(isArray == Array.isArray).to.be.true

    describe '#isObject', ->
      {isObject} = minutils

      it 'is true if argument is an Object', ->
        expect(isObject {}).to.be.true
        expect(isObject 'string').to.be.false

    describe '#isString', ->
      {isString} = minutils

      it 'is true if argument is a String', ->
        expect(isString 's').to.be.true
        expect(isString {'0': 's'}).to.be.false

    describe '#isNumber', ->
      {isNumber} = minutils

      it 'is a true if argument is a Number', ->
        expect(isNumber 10).to.be.true
        expect(isNumber '10').to.be.false
        expect(isNumber false).to.be.false

    describe '#isFunction', ->
      {isFunction} = minutils

      it 'is true if argument is a Function', ->
        expect(isFunction ->).to.be.true
        expect(isFunction {}).to.be.false

    describe '#isArguments', ->
      {isArguments} = minutils

      it 'is true if argument is the `arguments` object', ->
        expect(isArguments arguments).to.be.true
        expect(isArguments {}).to.be.false

    describe '#isRegExp', ->
      {isRegExp} = minutils

      it 'is true if argument is a RegExp', ->
        expect(isRegExp //).to.be.true
        expect(isRegExp {}).to.be.false

    describe '#isDate', ->
      {isDate} = minutils

      it 'is true if argument is a Date', ->
        expect(isDate (new Date)).to.be.true
        expect(isDate 10).to.be.false

    describe '#isBoolean', ->
      {isBoolean} = minutils

      it 'is true if argument is a Boolean', ->
        expect(isBoolean true).to.be.true
        expect(isBoolean false).to.be.true
        expect(isBoolean {}).to.be.false

    describe '#isEmpty', ->
      {isEmpty} = minutils

      it 'is true if the object is empty', ->
        expect(isEmpty null).to.be.true
        expect(isEmpty undefined).to.be.true
        expect(isEmpty {}).to.be.true
        expect(isEmpty []).to.be.true
        expect(isEmpty '').to.be.true
        expect(isEmpty true).to.be.true
        expect(isEmpty false).to.be.true

      it 'is false if the object is not empty', ->
        expect(isEmpty {key: 'val'}).to.be.false
        expect(isEmpty [1]).to.be.false
        expect(isEmpty 'string').to.be.false

    describe '#isBlank', ->
      {isBlank} = minutils

      it 'is true if the string only contains whitespace characters', ->
        expect(isBlank '').to.be.true
        expect(isBlank '         ').to.be.true
        expect(isBlank '\n\t\r \t \t \n \n  \r').to.be.true

      it 'is false if the string contains one or more non whitespace characters', ->
        expect(isBlank 'c').to.be.false
        expect(isBlank '     n ').to.be.false
        expect(isBlank '     \n blah ').to.be.false

    describe '#has', ->
      {has} = minutils

      it 'is true if `object` has own `key`', ->
        expect(has {name: 'Johnson'}, 'name').to.be.true
        expect(has {}, 'toString').to.be.false

  describe 'Arrays', ->
    describe '#first, #head', ->
      {first, head} = minutils

      it 'returns the first element', ->
        expect(head [1, 2, 3, 4, 5]).to.equal 1
        expect(first [1, 2, 3, 4, 5]).to.equal 1

      it 'returns the first n elements when provided a second argument', ->
        expect(head [1, 2, 3, 4, 5], 3).to.eql [1, 2, 3]
        expect(first [1, 2, 3, 4, 5], 3).to.eql [1, 2, 3]

    describe '#last', ->
      {last} = minutils

      it 'returns the last element of the array', ->
        expect(last [1, 2, 3, 4, 5]).to.equal 5

      it 'returns the last n elements when provided a second argument', ->
        expect(last [1, 2, 3, 4, 5], 3).to.eql [3, 4, 5]

    describe '#rest, #tail', ->
      {rest, tail} = minutils

      it 'returns the array without the first element', ->
        expect(rest [1, 2, 3, 4, 5]).to.eql [2, 3, 4, 5]
        expect(tail [1, 2, 3, 4, 5]).to.eql [2, 3, 4, 5]

      it 'returns the array starting at index n when provided a second argument', ->
        expect(rest [1, 2, 3, 4, 5], 3).to.eql [4, 5]
        expect(tail [1, 2, 3, 4, 5], 3).to.eql [4, 5]


  describe 'Functions', ->
    describe '#bind', ->
      {bind} = minutils

      it 'always calls `fn` in the `context` of `object`', ->
        obj = {name: 'the dude!'}
        unboundFn = -> @name
        boundFn = bind unboundFn, obj

        expect(unboundFn()).to.equal undefined
        expect(boundFn()).to.equal 'the dude!'

      it 'accepts default args and partially applies `fn`', ->
        obj = {name: 'the dude!'}

        fn = (greeting, greeting2) ->
          "#{greeting} #{greeting2} #{@name}"

        expect(bind(fn, obj)('hello', 'hi')).to.equal 'hello hi the dude!'
        expect(bind(fn, obj, 'hello')('hi')).to.equal 'hello hi the dude!'
        expect(bind(fn, obj, 'hello', 'hi')()).to.equal 'hello hi the dude!'

  describe 'Collections', ->
    describe '#each', ->
      {each} = minutils

      describe 'array collections', ->
        it 'iterates over each item in an array', ->
          coll = [1, 2, 3]
          each coll, (iterator = sinon.stub()), coll

          expect(iterator.calledThrice).to.be.true
          expect(iterator.firstCall.args).to.eql [1, 0, coll]
          expect(iterator.secondCall.args).to.eql [2, 1, coll]
          expect(iterator.thirdCall.args).to.eql [3, 2, coll]

          expect(iterator.alwaysCalledOn coll).to.be.true

      describe 'object collections', ->
        it 'iterates over each item in an object', ->
          person = {name: 'john'}
          each person, (iterator = sinon.stub()), person

          expect(iterator.calledOnce).to.be.true
          expect(iterator.firstCall.args).to.eql ['john', 'name', person]
          expect(iterator.alwaysCalledOn person).to.be.true

    describe '#map', ->
      {map} = minutils
      square = (val) -> val * val

      describe 'array collections', ->
        it 'is an array of the results of `fn` applied to each elem in coll', ->
          expect(map [2, 4], square).to.eql [4, 16]

        it 'is called with `context` as its `this` value', ->
          context = {}
          map (nums = [2, 4]), (iterator = sinon.stub()), context

          expect(iterator.calledTwice).to.be.true
          expect(iterator.firstCall.args).to.eql [2, 0, nums]
          expect(iterator.secondCall.args).to.eql [4, 1, nums]
          expect(iterator.alwaysCalledOn context).to.be.true

      describe 'object collections', ->
        it 'is an array of the results of `fn` applied to each key/value pair in coll', ->
          expect(map {two: 2, four: 4}, square).to.eql [4, 16]

        it 'is called with `context` as its `this` value', ->
          context = {}; person = {name: 'jon'}
          map person, (iterator = sinon.stub()), context

          expect(iterator.calledOnce).to.be.true
          expect(iterator.firstCall.args).to.eql ['jon', 'name', person]
          expect(iterator.alwaysCalledOn context).to.be.true

    describe 'reduce', ->
      {reduce} = minutils
      sum = (x, y) -> x + y

      reduceEmptyCollectionWithNoInitialValue = (coll) ->
        -> reduce coll, (->)

      describe 'array collections', ->
        it 'returns a value from a list of values, maintaining context', do ->
          callArgs = []
          callCount = 0
          callContext = []

          specialSum = (x, y) ->
            callCount++
            callArgs.push arguments
            callContext.push this
            sum arguments...

          alwaysCalledOn = (val) ->
            for ctx in callContext
              return false unless ctx is val
            true

          ->
            context = {}
            result = reduce (nums = [1, 2, 3]), specialSum, 0, context

            expect(callCount).to.equal 3
            expect(callArgs[0]).to.eql [0, 1, 0, nums]
            expect(callArgs[1]).to.eql [1, 2, 1, nums]
            expect(callArgs[2]).to.eql [3, 3, 2, nums]
            expect(alwaysCalledOn context).to.be.true
            expect(result).to.equal 6

        it 'throws an error if the collection is empty and no initial value', ->
          expect(reduceEmptyCollectionWithNoInitialValue []).to.throw 'Reduce of empty array with no initial value'

        it 'uses the first value as `memo` if no initial value specified', ->
          expect(reduce [1, 2], sum).to.equal 3

      describe 'object collections', ->
        it 'returns a value from a list of values, maintaining context', do ->
          callArgs = []
          callCount = 0
          callContext = []

          specialSum = (x, y) ->
            callCount++
            callArgs.push arguments
            callContext.push this
            sum arguments...

          alwaysCalledOn = (val) ->
            for ctx in callContext
              return false unless ctx is val
            true

          ->
            context = {}
            result = reduce (nums = {'one': 1, 'two': 2, 'three': 3}), specialSum, 0, context

            expect(callCount).to.equal 3
            expect(callArgs[0]).to.eql [0, 1, 'one', nums]
            expect(callArgs[1]).to.eql [1, 2, 'two', nums]
            expect(callArgs[2]).to.eql [3, 3, 'three', nums]
            expect(alwaysCalledOn context).to.be.true
            expect(result).to.equal 6

        it 'throws an error if the collection is empty and no initial value', ->
          expect(reduceEmptyCollectionWithNoInitialValue {}).to.throw 'Reduce of empty array with no initial value'

        it 'uses the first value as `memo` if no initial value specified', ->
          expect(reduce {'one': 1, 'two': 2}, sum).to.equal 3

    describe '#partition', ->
      {partition} = minutils
      isEven = (n) -> n % 2 is 0

      it 'is an array of two empty arrays if passed an empty collection', ->
        expect(partition [], isEven).to.eql [[], []]
        expect(partition {}, isEven).to.eql [[], []]

      describe 'array collections', ->
        it 'is an array of two arrays', ->
          expect(partition [1, 2, 3, 4, 5], isEven).to.eql [[2, 4], [1, 3, 5]]

        it 'is called with `context` as its `this` value', ->
          context = {}
          partition (nums = [1, 2]), (iterator = sinon.stub()), context

          expect(iterator.calledTwice).to.be.true
          expect(iterator.firstCall.args).to.eql [1, 0, nums]
          expect(iterator.secondCall.args).to.eql [2, 1, nums]
          expect(iterator.alwaysCalledOn context).to.be.true

      describe 'object collections', ->
        it 'is an array of two arrays', ->
          expect(partition {'one': 1, 'two': 2, 'three': 3}, isEven).to.eql [
            [['two', 2]],
            [['one', 1], ['three', 3]]
          ]

        it 'is called with `context` as its `this` value', ->
          context = {}; nums = {one: 1}
          partition nums, (iterator = sinon.stub()), context

          expect(iterator.calledOnce).to.be.true
          expect(iterator.firstCall.args).to.eql [1, 'one', nums]
          expect(iterator.alwaysCalledOn context).to.be.true
