    "use strict";

    var app = angular.module('appFilters', []);
    app.filter('asDate', function () {
	    return function (input) {
	        return new Date(parseInt(input) * 1000)
	    }
	});
