
require('shelljs/make');
var path = require('path');

var deps = [ ];

target.all = function() {
  target.update();
  exec( 'component build --dev --use tool/stylus,tool/templates' );
}

target.production = function() {
  target.update();
  exec( 'component build --use tool/stylus,tool/templates,tool/uglify' );
}

target.jade = function() {

}

target.update = function() {
  target.updateScriptList();
  target.updateDeps();
  echo( 'All done!' );
};

target.updateSelf = function() {
  return updateScriptList( __dirname, 'src' );
};

target.updateDeps = function() {
  deps.forEach( function( d ) {
    cd( path.resolve( __dirname, d ) );
    exec( 'node make update' );
  } );
}

target.help = function() { echo( Object.keys( target ) ); }


function findJsFileInDir( dir ) {
  return find( dir )
    .filter( function( f ) { return /\.js$/.test( f ); } )
    .filter( function( f ) { return !/\.idl/.test( f ); } );
}

function isSameStringList( a, b ) {
  var copyA = a.slice().sort(), copyB = b.slice().sort();
  return copyA.every( function( el, ind ) {
    return el === copyB[ind];
  } );
}

function updateScriptList( dir, srcDir ) {
  srcDir || ( srcDir = dir );
  cd( dir );
  var config = JSON.parse( cat( 'component.json' ) );
  var oldList = config.scripts;
  var newList = findJsFileInDir( srcDir );
  var isChanged = !isSameStringList( oldList, newList );

  echo( 'In ' + path.resolve( dir ) + ' :');
  if ( isChanged && newList.length > 0 ) {
    echo( 'Old scripts list: ', oldList );
    echo( 'New scripts: ', newList  );
    echo( 'The file list is changed, update component.json...' );
    cp( '-f', 'component.json', 'component.json.bak' );
    config.scripts = newList;
    JSON.stringify( config, null, 2 ).to( 'component.json' );
  } else {
    echo( 'Scripts list is not changed, do nothing.' )
  }
  return isChanged;
}