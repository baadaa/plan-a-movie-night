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


app.controller('HomeCtrl', ['currentAuth', function(currentAuth) {
  // currentAuth (provided by resolve) will contain the
  // authenticated user or null if not logged in
  console.log(currentAuth)
}]);

app.controller('AuthCtrl', ['$scope', '$location', 'currentAuth', 'FirebaseAuthService',
 function($scope, $location, currentAuth, FirebaseAuthService) {
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
      	$location.path('/');
      }
    });
}]);


