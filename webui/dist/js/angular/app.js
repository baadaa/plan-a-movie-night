"use strict";

var app = angular.module('sbAdminApp', [
	'FirebaseAuth',
	'ui.bootstrap',
	'appFilters',
	'appRoutes',
	'appControllers',
	'appDirectives'
]).constant('firebaseConfig', {
	name	: 'Plan a Movie Night',
	uri		: 'pamn',
	url		: function(){
		return 'https://'+this.uri+'.firebaseio.com'
	}
});

