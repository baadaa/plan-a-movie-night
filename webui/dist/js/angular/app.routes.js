'use strict';

var app = angular.module('appRoutes', [
    'ngRoute'
]);
// app.config(['$routeProvider', function ($routeProvider) {
//     $routeProvider.
//         when('/login', {
//             templateUrl: '/pages/login.html',
//             controller: 'HomeCtrl'
//         }).
//         when('/', {
//             templateUrl: '/pages/test.html',
//             controller: 'HomeCtrl'
//         }).
//         otherwise({
//             redirectTo: '/'
//         });
// }]);

app.run(['$rootScope', '$location', function($rootScope, $location) {
    $rootScope.$on('$routeChangeError', function(event, next, previous, error) {
      // We can catch the error thrown when the $requireAuth promise is rejected
      // and redirect the user back to the home page
      if (error === 'AUTH_REQUIRED') {
        $location.path('/login');
      }
    });
}]);

app.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/login', {
      // the rest is the same for ui-router and ngRoute...
      controller: 'AuthCtrl',
      templateUrl: '/pages/login.html',
      resolve: {
        // controller will not be loaded until $waitForAuth resolves
        // Auth refers to our $firebaseAuth wrapper in the example above
        'currentAuth': ['FirebaseAuthService', function(FirebaseAuthService) {
          // $waitForAuth returns a promise so the resolve waits for it to complete
          return FirebaseAuthService.auth.$waitForAuth();
        }]
      }
    }).when('/', {
      // the rest is the same for ui-router and ngRoute...
      controller: 'DashboardCtrl',
      templateUrl: '/pages/main.html',
      resolve: {
        // controller will not be loaded until $requireAuth resolves
        // Auth refers to our $firebaseAuth wrapper in the example above
        'currentAuth': ['FirebaseAuthService', function(FirebaseAuthService) {
          // $requireAuth returns a promise so the resolve waits for it to complete
          // If the promise is rejected, it will throw a $stateChangeError (see above)
          return FirebaseAuthService.auth.$requireAuth();
        }]
      }
    }).when('/movies/:subtype?', {
      // the rest is the same for ui-router and ngRoute...
      controller: 'MoviesCtrl',
      templateUrl: '/pages/main.html',
      atk: 'falcon kick',
      resolve: {
        // controller will not be loaded until $requireAuth resolves
        // Auth refers to our $firebaseAuth wrapper in the example above
        'currentAuth': ['FirebaseAuthService', function(FirebaseAuthService) {
          // $requireAuth returns a promise so the resolve waits for it to complete
          // If the promise is rejected, it will throw a $stateChangeError (see above)
          return FirebaseAuthService.auth.$requireAuth();
        }]
      }
    }).
    otherwise({
        templateUrl: '/pages/main.html',
    });
}]);



