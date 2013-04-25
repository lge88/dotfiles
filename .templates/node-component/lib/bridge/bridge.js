
// var $ = require('jquery');
// var Deferred = $.Deffered;
var Deferred = require('tiny-deferred');
var d = new Deferred();

document.addEventListener('WebViewJavascriptBridgeReady', onBridgeReady, false);

function onBridgeReady(event) {
  var bridge = event.bridge;
  bridge.init(function(message, responseCallback) {
    console.log('JS got a message', message);
    var data = { 'Javascript Responds':'Wee!' };
    console.log('JS responding with', data);
    responseCallback(data);
  });
  d.resolve(bridge);
}

exports.getBridge = function() {
  return d;
};
