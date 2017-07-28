var exec = require('cordova/exec');

var PhotosPlugin = {};

var imageURLtoSave;


PhotosPlugin.takePhoto = function(imageURL, successCallback, errorCallback) {
	imageURLtoSave = imageURL;
  	exec(successCallback, errorCallback, "PhotosPlugin", "openCamera", [ ]);
};


PhotosPlugin.savePhotoToCameraRoll = function(message, successCallback, errorCallback) {
  	exec(successCallback, errorCallback, "PhotosPlugin", "saveToCameraRoll", [ imageURL ]);
};


PhotosPlugin.saveTodaysDateInDocuments = function(greeting, successCallback, errorCallback) {
	var dateStr = new Date().toJSON();
  	exec(successCallback, errorCallback, "PhotosPlugin", "saveTodaysDate", [ dateStr, 'Julia' ]);
};


module.exports = PhotosPlugin;