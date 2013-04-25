var path = require('path');
var appName = path.basename(__dirname);
var express = require("express");
var app = express();
var _ = require('underscore');
var fs = require('fs');
var readdir = fs.readdirSync;
var read = fs.readFileSync;

app.set('views', __dirname);


app.get('/apps', handleRequest);
app.get('/' + appName, handleRequest);

function handleRequest(req, res) {
  var format = req.query.format || 'html';
  var type = req.query.type;
  var list = getApplicationList(type);
  
  if (format === 'html') {
    res.render('index', {
      apps: list.map(function(it) {
        return {
          name: it.name,
          url: 'http://' + req.headers.host + '/' + it.name
        }
      })
    });
  } else {
    res.json(list);
  }  
}


var typeRexMap = {
  app: /^app-/,
  demo: /^demo-/
};

// Get a list of applications.
// An application can be of type:
// 1) 'app' - regular application
// 2) 'demo' - demo application
// 3) 'unit' - unit test application for module
function getApplicationList(type) {
  var ret = readdir(path.resolve(__dirname, '..'));

  // Filter based on folder name convention
  if (type!=='unit') {
    ret = ret.filter(function(it) {
      return it.match(typeRexMap[type]) !== null;
    });
  }

  // Read the component.json file, filter out the invalid ones
  ret = ret.map(function(it) {
    try {
      var conf = JSON.parse(read(path.resolve(__dirname, '..', it, 'component.json'), 'utf8'));
    } catch(e) {
      return false;
    }
    return conf;
  }).filter(function(it) {
    if (it) {
      if (typeof it === 'object') {
        return it['express_server'];
      }
    }
    return false;
  });

  // Filter out the whose component.json do not 'unit' entry
  if (type==='unit') {
    ret = ret.filter(function(it) {
      return !!it.unit;
    });
  }

  ret = ret.map(function(it) {
    return {
      name: it.name
    };
  });

  return ret;
  
}

module.exports = exports = function(io, list) {
  return app;
};
