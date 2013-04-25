var fs = require('fs');
var read = fs.readFileSync;

function unit(builder) {
  ["scripts", "styles", "files", "images", "fonts"].forEach(function(t) {

    builder.hook('before ' + t, function(type) {
      
      return function(pkg){
        var unit = pkg.conf.unit;
        if (!unit) return;

        var files = unit[type];
        
        if (files && Array.isArray(files) && files.length > 0) {          
          files.forEach(function(file) {
            pkg.addFile(type, file, read(pkg.path(file), 'utf8'));
          });
        }
      }
      
    }(t));
    
  });

  builder.hook('before scripts', function(pkg) {
    var unit = pkg.conf.unit;
    if (!unit) return;

    // change entry point to unit test main.js script
    var main = unit["main"];
    if (main) {
      pkg.conf.main = main;
    }
  });
}

module.exports = exports = unit;
