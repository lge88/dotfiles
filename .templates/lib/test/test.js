
var lib = require( '__pkgName__' );
var expect = require( 'expect.js' );

describe( '__pkgName__', function() {

  it( 'should return Hello World', function() {
    expect( lib() ).to.be( 'Hello World' );
  } );

} );
