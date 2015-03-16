"use strict";

var app = angular.module('appControllers', [
	'ngRoute'
]);
// app.controller('HomeCtrl', ['$scope', '$firebaseArray', '$firebaseObject', 'firebaseConfig', 'FirebaseAuthService',
// 	function ($scope, $firebaseArray, $firebaseObject, firebaseConfig, FirebaseAuthService) {

// 		var ref = new Firebase(firebaseConfig.url());
// 	    var eventsRef = ref.child('events');
// 		$scope.events = $firebaseObject(eventsRef);
// 	    // create a query for the most recent 5 messages on the server
// 	    var query = eventsRef.orderByChild("event_date").limitToLast(5);
// 	    // the $firebaseArray service properly handles Firebase queries as well
// 	    $scope.filteredEvents = $firebaseObject(query);

// 	    console.log(FirebaseAuthService);

		
// 	}
// ]);

// app.controller('AuthCtrl', ['$scope', 'FirebaseAuthService',
// 	function($scope, $firebaseAuth) {
		
// 		$scope.login = function() {
// 			$scope.authData = null;
// 			$scope.error = null;

// 			FirebaseAuthService.auth.$authWithOAuthPopup('facebook').then(function(authData) {
// 				$scope.authData = authData;
// 			}).catch(function(error) {
// 				$scope.error = error;
// 			});
// 		};
// 	}
// ]);


app.controller('DashboardCtrl', ['$scope', 'currentAuth', function($scope, currentAuth) {
  // currentAuth (provided by resolve) will contain the
  // authenticated user or null if not logged in

  $scope.title = 'Dashboard';
  $scope.subview = 'dashboard';
}]);

app.controller('MoviesCtrl', ['$scope', '$routeParams', 'currentAuth', 
  function($scope, $routeParams, currentAuth) {
    // currentAuth (provided by resolve) will contain the
    // authenticated user or null if not logged in

    switch($routeParams.subtype){
      case 'upcoming':
        $scope.title = 'Upcoming Movies';
        break;

      default:
        $scope.title = 'Movies';
        break;
    }
    
    $scope.subview = 'movies';
    $scope.movies = [
      {
        id: 'avg2',
        title: 'Avengers 2',
      },
      {
        id: ' spdrmn3',
        title: 'Spiderman 3',
      }
    ];
}]);

app.controller('AuthCtrl', ['$rootScope', '$scope', '$location', 'currentAuth', 'FirebaseAuthService',
 function($rootScope, $scope, $location, currentAuth, FirebaseAuthService) {
  // currentAuth (provided by resolve) will contain the
  // authenticated user or null if not logged in
  $scope.login = function(){
  	FirebaseAuthService.auth.$authWithOAuthPopup('facebook').then(function(authData) {
		$scope.authData = authData;
	}).catch(function(error) {
		$scope.error = error;
	});
  }

  $scope.logout = function(){
  	FirebaseAuthService.auth.$unauth();
  }

  $scope.currentAuth = currentAuth;
  $scope.auth = FirebaseAuthService.auth;
  // any time auth status updates, add the user data to scope
    $scope.auth.$onAuth(function(authData) {
      $scope.currentAuth = authData;
      if(authData){
        FirebaseAuthService.saveUser(authData);
      	$location.path('/');
      }
    });

    $rootScope.single_view = true;
}]);


