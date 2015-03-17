"use strict";

var app = angular.module('sbAdminApp', [
	'FirebaseAuth',
	'Tmdb',
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
}).constant('tmdbConfig', {
	api	: '0e7e1de1caeef3e82f74e1096b77f839',
});;

