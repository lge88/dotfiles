
require( 'shelljs/global' );
var path = require( 'path' );

exports.priority = 0;

exports.execute = function() {

  var pkgName = path.basename( pwd() );

  [ 'component.json', 'Makefile', 'test/test.js', 'examples/index.html', 'lib/index.js' ].forEach( function( f ) {
    sed( '-i', /__pkgName__/g, pkgName, f );
  } );

}
