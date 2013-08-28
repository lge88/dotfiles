
require( 'shelljs/global' );

var root = __dirname + '/..'
var excludedPattern = /^(bin|build|components|node_modules)\//;
var scriptsPattern = /\.js$/;
var stylesPattern = /\.(css|styl)$/;

cd( root );
var config = JSON.parse( cat( 'component.json' ) );

var files =  ls( '-R', root )
  .filter( function( f ) {
    return !excludedPattern.test( f );
  } );

config.scripts = files
  .filter( function( f ) {
    return scriptsPattern.test( f );
  } );

config.styles = files
  .filter( function( f ) {
    return stylesPattern.test( f );
  } );

cp( '-f', 'component.json', 'bin/component.json.bak' );
JSON.stringify( config, null, 2 ).to( 'component.json' );
