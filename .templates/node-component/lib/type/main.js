var expect = require('expect.js');
var type = require('./type');


// Do some unit testing with this module:

var data = [
  [ [1,3,4], 'array'],
  [ [], 'array'],
  [ {}, 'object'],
  [ { x: [1,2,43], y: "test" }, 'object'],
  [ /^regexp$/, 'regexp'],
  [ 'string', 'string'],
  [ "another string", 'string'],
  [ 12, 'number'],
  [ 1.22, 'number'],
  // [ document.createElement('div'), 'element']
]



describe('test', function(){

  data.forEach(function(d) {
    it(d[0] + ' should be type of ' + d[1], function(){
      expect(type(d[0])).to.equal(d[1]);
    });

  });

});

