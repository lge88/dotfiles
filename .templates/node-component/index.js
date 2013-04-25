
var conf = require('./configure.js');
var express = require('express');
var app = express();
var mongoose = require('mongoose');
var path = require('path');

mongoose.connect('mongodb://localhost/ifea');

// Global express settings:
app.set('view engine', 'jade');
app.get('env') || app.set('env', 'development');

app.set('port', conf.port);
if (app.get('env') === 'development') {
  app.use(express.logger('dev'));
}

app.use(express.methodOverride());
app.use(express.static(__dirname + '/public'));

var server = require('http').createServer(app);
var sio = require('socket.io').listen(server);

// Global sio configure:
if (app.get('env') === 'development') {
  
} else {
  sio.enable('browser client minification');
  sio.enable('browser client etag');
  sio.enable('browser client gzip');
  sio.set('log level', 1);   
  sio.set('transports', [
    'websocket',
    'flashsocket',
    'htmlfile',
    'xhr-polling',
    'jsonp-polling',
  ]);
  sio.set('log level', 0);
}
// sio.set('log level', 0);

server.listen(app.get('port'), function(){
  console.log("Express server and socket.io server listening on port " + app.get('port'));
});


// Mount applications:

conf.apps.forEach(function(it) {
  app.use(require(it)(sio));
});

app.get('/', function(req, res) {
  res.redirect('/apps');
});
