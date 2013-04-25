var path = require('path');
var pkgName = path.basename(__dirname);
var build = require('build')({ name: pkgName });
var express = require('express');
var app = express();

app.set('views', __dirname);

app.get('/' + pkgName, build, function(req, res) {
  res.render('index');
});

module.exports = function(io) {
  return app;
};