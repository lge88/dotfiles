var Builder = require('component-builder');
var templates = require('./templates');
var stylus = require('./stylus');
var unit = require('./unit');
var uglifyjs = require('uglify-js');
var uglify = require('./uglify');


var fs = require('fs');
var exists = fs.existsSync;
var write = fs.writeFileSync;
var path = require('path');
var join = path.join;
var mkdirp = require('mkdirp').sync;

module.exports = exports = builder;

var defaultOptions;
exports.reset = function() {
  defaultOptions = {
    root: path.resolve(__dirname, '../..'),
    paths: [
      '.',
      'lib'
    ],
    enableSourceURLs: true,
    enableOptimization: false,
  };
};

exports.reset();

exports.options = function() {
  return defaultOptions;
};

exports.configure = function(key, value) {
  var conf = {};
  if (arguments.length === 2 && typeof key === 'string') {
    conf[key] = value;
  } else if (typeof key === 'object') {
    conf = key;
  } else {
    console.log('Not valid arguments for configure:', arguments);
    return;
  }

  for (var i in conf) {
    options[i] = conf[i];
  }
};

// TODO: accept option to select build targets

function builder(options) {
  if (typeof options !== 'object') {
    throw "invalid arguments";
  }

  if (!options.src && !options.name) {
    throw "at least one of src or name field show be provided"
  }

  var root = options.root || defaultOptions.root;
  var paths = options.paths || defaultOptions.paths || ['.'];
  var enableSourceURLs = options.enableSourceURLs || defaultOptions.enableSourceURLs;
  var enableOptimization = options.enableOptimization || defaultOptions.enableOptimization;
  var src, pkgName, dest, targets, code;

  if (options.src) {
    src = path.resolve(root, options.src);
    pkgName = options.name || path.basename(src);
  } else {
    pkgName = options.name;
    src = findSrc(pkgName, root, paths);
    if (src.length === 0) {
      throw "Can't find pakage " + pkgName;
    }
    src = src[0];
    if (src.lenght > 1) {
      console.warn('More than one package src folder found,' +
                   ' builder pick the first one: ' + src);
    }
  }
  
  var dest = options.dest ?
    path.resolve(root, dest) :
    path.resolve(root, 'public', pkgName);
  
  return  function(req, res, next){
    var _builder = new Builder(src);
    mkdirp(dest);

    paths.forEach(function(p) {
      _builder.addLookup(p);
    });
    
    _builder.copyAssetsTo(dest);
    _builder.use(stylus);
    _builder.use(templates);
    _builder.use(unit);

    if (enableSourceURLs && !enableOptimization) {
      _builder.addSourceURLs();
    }
    
    if (enableOptimization) {
      _builder.use(uglify);
    }
    
    _builder.build(function(err, res){
      if (err) return next(err);
      
      code = res.require + res.js + 'require(\'' + pkgName + '\');';
      if (enableOptimization) {
        code = uglifyjs.minify(code, { fromString: true }).code;
      }
      
      write(join(dest, 'app.js'), code);
      write(join(dest, 'app.css'), res.css);
      return next();
    });
  };
}

// Leave it here for back compatibility, remove in the future
exports.build = builder;
exports.builder = builder;

function findSrc(name, root, paths) {
  return paths.map(function(p) {
    return path.resolve(root, p, name);
  }).filter(function(p) {
    return exists(p);
  });
}
