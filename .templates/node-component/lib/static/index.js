var path = require('path');
var appName = path.basename(__dirname);

var express = require('express');
var app = express();

app.use('/' + appName, express.directory(path.resolve(__dirname, '../../..'), {
  icons: true,
  hidden: true
}));

app.use('/' + appName, express.static(path.resolve(__dirname, '../../..'), {
  redirect: false
}));

module.exports = function(io) {
  return app;
};
