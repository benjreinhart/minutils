minutils = require '../'
{expect} = require 'chai'

describe 'minutils', ->

  describe 'Utilities', ->
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

    describe '#has', ->
      {has} = minutils

      it 'is true if `object` has own `key`', ->
        expect(has {name: 'Johnson'}, 'name').to.be.true
        expect(has {}, 'toString').to.be.false

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

  describe 'Collections', ->
    describe '#partition', ->
      {partition} = minutils
      isEven = (n) -> n % 2 is 0

      it 'is an array of two empty arrays if passed an empty collection', ->
        expect(partition [], isEven).to.eql [[], []]
        expect(partition {}, isEven).to.eql [[], []]

      describe 'arrays', ->
        it 'is an array of two arrays', ->
          expect(partition [1, 2, 3, 4, 5], isEven).to.eql [[2, 4], [1, 3, 5]]

      describe 'objects', ->
        iterator = (key, val) -> isEven(val)

        it 'is an array of two arrays', ->
          expect(partition {'one': 1, 'two': 2, 'three': 3}, iterator).to.eql [
            [['two', 2]],
            [['one', 1], ['three', 3]]
          ]






