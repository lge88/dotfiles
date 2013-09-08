var ISEViewport = require( 'ise-viewport' );
var randomCubes = require( 'three-random-cubes' );
var EditorControls = require( 'ise-editor-controls' );

var viewport = ISEViewport();
var controls = EditorControls( viewport.camera, viewport.container );

// build scene:
var cubes = randomCubes().map( function( c ) { viewport.scene.add(c); return c; } );
