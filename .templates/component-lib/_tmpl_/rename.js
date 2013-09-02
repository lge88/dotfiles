
require( 'shelljs/global' );
var path = require( 'path' );

// exports.priority = 0;

// exports.afterCopy = function() {

//   var pkgName = path.basename( pwd() );

//   [ 'component.json', 'Makefile', 'test/test.js', 'examples/index.html', 'lib/index.js' ].forEach( function( f ) {
//     sed( '-i', /__pkgName__/g, pkgName, f );
//   } );

// }


// require( 'shelljs/global' );
// var path = require( 'path' );

exports.afterCopy = function( context ) {

  var newPkgName = context.pkgName, dest = context.dest;
  var comp, oldName, re;
  var files = [ 'component.json', 'Makefile', 'test/test.js', 'examples/index.html', 'lib/index.js' ]
  // [ 'component.json', 'Makefile', 'index.html', 'main.js', 'main.css' ];

  cd( dest );

  comp = JSON.parse( cat( 'component.json' ) );
  oldName = comp.name;
  re = RegExp( '\\b' + oldName + '\\b', 'g' );

  comp.paths || ( comp.paths = [] );
  addToSet( comp.paths, process.env.DEVELOP_PATH + '/js' );
  addToSet( comp.paths, process.env.ISE_PATH + '/lib' );
  addToSet( comp.paths, process.env.ISE_PATH + '/lib-client' );
  JSON.stringify( comp, null, 2 ).to( 'component.json' );

  files.forEach( function( f ) {
    sed( '-i', re, newPkgName, f );
  } );

  console.log( 'Rename from project from ' + oldName + ' to ' + newPkgName );
}

exports.afterCopy.order = 1;

function addToSet( arr, item ) {
  if ( -1 === arr.indexOf( item ) ) {
    arr.push( item );
    return true;
  }
  return false;
}

if ( !module.parent ) {
  var context = {}, run = exports.afterCopy;
  context.pkgName = process.argv[2] || path.basename( path.resolve( __dirname, '..' ) );
  context.dest = path.resolve( __dirname, '..' );
  run( context );
}
