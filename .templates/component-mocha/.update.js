
require('shelljs/global');

var re = /^..*\.js$/;

ls( '.' )
  .filter( function( f ) {
    return re.test( f );
  } )
  .filter( function( f ) {
    return f !== 'all.js';
  } )
  .map( function( f ) {
    return 'require( \'./' + f + '\' );';
  } )
  .join( '\n' )
  .to( 'entry.js' );

var conf = JSON.parse( cat( 'component.json' ) );
conf.scripts = ls( '.' )
  .filter( function( f ) {
    return re.test( f );
  } );

cp( 'component.json', 'component.json.bak' );
JSON.stringify( conf, null, 2 ).to( 'component.json' );
