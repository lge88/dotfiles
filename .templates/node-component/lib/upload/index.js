var path = require('path');
var fs = require('fs');
var pkgName = path.basename(__dirname);
var builder = require('build').builder, build;
var express = require('express');
var app = express();
var mkdirp = require('mkdirp').sync;
var mongoose = require('mongoose');
require('./FileSchema');
var File = mongoose.model('File');
var _ = require('underscore');
var Hashids = require("hashids");
var hashids = new Hashids("images upload");

var urls = {
  'static': '/images',
  'upload': '/upload',
  'uploadUI': '/image-upload'
};

var dirs = {
  'tmp': '/tmp/ifea',
  'image': path.resolve(__dirname, '../../resources/images'),
  'misc': path.resolve(__dirname, '../../resources/misc')
};

_.each(dirs, function(d) {
  mkdirp(d);
});

// Static file service:
app.use(urls.static, express.static(dirs.image));
app.use(urls.static, express.directory(dirs.image));

// Upload UI:
app.set('views', __dirname);
if (app.get('env') === 'development') {
  build = builder({ name: pkgName });
  app.get(urls.uploadUI, build, handleIndexRequest);
} else {
  build = builder({
    name: appName,
    enableSourceURLs: false,
    enableOptimization: true
  });
  build({}, {}, function() {
    app.get(urls.uploadUI, handleIndexRequest);
  });
}

// Upload service:
// Rename;
// Oragnize: Put it in correct folder: image type -> imageDir, other type -> misc;
// Write the record to the database; (optional)
// Respond to client;
// Handler Error;
app.post(
  urls.upload,
  express.bodyParser({
    keepExtensions : true,
    uploadDir: urls.tmp
  }),
  renameFile,
  organizeFile,
  // storeFileRecordToDb,
  function(req, res) {
    var file = req.files.fileupload;
    res.json(200, _.pick(
      file,
      'name',
      'size',
      'url',
      'path',
      'extname',
      'createdAt',
      'lastViewedDate',
      'from'
    ));
  },
  function(err, req, res) {
    res.json(400, err);
  }
);


function handleIndexRequest(req, res) {
  res.render('index');
}

function renameFile(req, res, next) {
  if (req.files && req.files.fileupload) {
    var inFile = req.files.fileupload;
    File.find({ name: inFile.name }, function(err, file) {
      if (err) {
        next(err);
        return;
      }
      if (file) {
        var ext = path.extname(inFile.name);
        var base = path.basename(inFile.name, ext);
        inFile.name = base + '-' + hashids.encrypt(Date.now()) + ext;
      }
      next();
    });
  } else {
    next('Bad request');
  }
}

function organizeFile(req, res, next) {
  var inFile = req.files.fileupload;
  fs.readFile(req.files.fileupload.path, function(err, data) {
    if (err) {
      next(err);
      return;
    }
    // TODO: Add type check here
    var newPath = path.join(dirs.image, inFile.name);
    fs.writeFile(newPath, data, function(err) {
      if (err) {
        next(err);
        return;
      }
      inFile.path = newPath;
      next();
    });
  });
}

function storeFileRecordToDb(req, res, next) {
  var obj = _.pick(
    req.files.fileupload,
    'type',
    'name',
    'size',
    'path',
    'lastModifiedDate'
  );

  obj.from = req.ip;
  obj.url = path.join('/images/', obj.name);
  var file = new File(obj);
  
  file.save(function(err) {
    if (err) {
      next(err);
    } else {
      req.files.fileupload = file;
      next();
    }
  });
};

function handleListRequest(req, res, next) {
  var page = req.param('page') > 0 ? req.param('page') : 0;
  var perPage = (req.param('perPage') > 0 && req.param('perPage') > 50) ? req.param('perPage') : 20;
  var ext = req.param('ext');
  debugger;
  try {
    ext = Array.isArray(ext) ?
      new RegExp('(' + ext.join('|') + ')') :
      /(.js|.obj|.msh|.stl|.vtk|.utf8)/;
  } catch(e) {
    console.log('Invalid RegExp: ', ext);
    ext = /(.js|.obj|.msh|.stl|.vtk|.utf8)/;
  }

  var name = req.param('name');
  var query = {
    shared : true,
    extname : ext
  };
  // if (ext) {
  //   if (ext.slice(0, 1) !== '.') {
  //     query.extname = '.' + ext;
  //   } else {
  //     query.extname = ext;
  //   }
  // }
  if (name) {
    query.name = name;
  }

  File
    .find(query, "name url size from extname createdAt lastViewedDate")
    .sort({'lastViewedDate': -1})
    .limit(perPage)
    .skip(perPage * page)
    .exec(function(err, files) {
      if (err) {
        console.error(err);
        return res.render('500');
      }
      return File.find(query).count().exec(function (err, count) {
        var start, end, json = {};
        start = perPage * page;
        end = perPage * page + perPage - 1;
        end = (end < count) ? end : count;
        json.total = count;
        json.page = page;
        json.perPage = perPage;
        json.range = [start, end];
        json.files = files;
        res.json(200, json);
      });
    });
};

function findById(req, res, next, id) {
  File.findOne({_id : id}).exec(function(err, file) {
    if (err) {
      console.error(err);
      res.render('404');
    }
    if (file && file._absPath) {
      req.fileAbsPath = file._absPath;
      next();
    }
  });
};

function updateFileTimeStamp(req, res) {
  File.findOne({url : req.param('url')}).exec(function(err, file) {
    if (err) {
      console.error(err);
      res.render('404');
      return;
    }
    file.lastViewedDate = Date.now();
    file.save(function(err) {
      if (err) {
        console.error(err);
        res.render('500');
        return;
      }
      res.send(200);
    });
  });
};

function send(req, res) {
  fs.exists(req.fileAbsPath, function(e) {
    if (e) {
      res.sendfile(req.fileAbsPath);
    } else {
      res.render(404);
    }
  });
};


module.exports = function(io) {
  return app;
};

