// File schema
var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var path = require('path');

var FileSchema = new Schema({
  name : { type : String, default : '', trim : true } ,
  url : { type : String, default : '', trim : true } ,
  type : { type : String, trim : true },
  _absPath : { type : String, default : '', trim : true },
  extname : { type : String, default : '', trim : true },
  size : { type : Number }, 
  createdAt  : { type : Date, default : Date.now },
  lastModifiedDate : { type : Date, default : Date.now },
  lastViewedDate : { type : Date, default : Date.now },
  shared : { type : Boolean, default : true },
  from : { type : String },
  owner : { type : Schema.ObjectId, ref : 'User' }
});

FileSchema.pre('save', function(next) {
  this.extname = path.extname(this.name);
  next();
});

FileSchema.static('rename', function(name, prefix) {
  if (typeof name === 'string') {
    return prefix + '-' +
      name.replace(/[\/\s]+/g, '-')
      .replace(/-+/g,'-')
      .toLowerCase();
  } else {
    return false;
  }
});

mongoose.model('File', FileSchema);
module.exports = exports = FileSchema;
