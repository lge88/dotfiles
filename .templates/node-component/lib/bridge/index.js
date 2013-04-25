var path = require('path');
var appName = path.basename(__dirname);
var build = require('build').build({ name: appName });

var express = require('express');
var app = express();
app.set('views', __dirname);

app.get('/' + appName, build, function(req, res) {
  res.render('index');
});

module.exports = function(io) {
  return app;
};
