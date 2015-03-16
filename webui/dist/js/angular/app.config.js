"use strict";

var app = angular.module('sbAdminApp', [
	'FirebaseAuth',
	'appFilters',
	'appRoutes',
	'appControllers'
]).constant('firebaseConfig', {
	name	: 'Plan a Movie Night',
	uri		: 'pamn',
	url		: function(){
		return 'https://'+this.uri+'.firebaseio.com'
	}
});

