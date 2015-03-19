"use strict";

var app = angular.module('appDirectives', [
	'FirebaseAuth',
  'ui.bootstrap'
]);

app.directive('navigation', [function() {
  return {
  	replace: true,
    restrict: 'E',
    templateUrl: '/partials/navigation.html',
    controller: function($scope, $element, FirebaseAuthService, $modal, $log){
    	$scope.authHandler = FirebaseAuthService;
      $scope.pending_events_count = 3;

      $scope.items = ['item1', 'item2', 'item3'];
      $scope.openCreateEventModal = function () {
        var modalInstance = $modal.open({
          templateUrl: '/modals/create_event.html',
          controller: 'EventCreateCtrl',
          size: 'sm',
          resolve: {
            items: function () {
              return $scope.items;
            },
          }
        });

        modalInstance.result.then(function (selectedItem) {
          $scope.selected = selectedItem;
        }, function () {
          $log.info('Modal dismissed at: ' + new Date());
        });
      };
    },
    link: function(scope, el, attr) {}
  }
}]);

app.directive('liUser', function() {
  return {
  	replace: true,
    restrict: 'E',
    templateUrl: '/partials/navigation/li-user.html',
    controller: function($scope, $element, FirebaseAuthService, $location){
    	$scope.authData = FirebaseAuthService.auth.$getAuth();
      if($scope.authData){
        $scope.name = $scope.authData.facebook.displayName;
      } else {
        $scope.name = 'Guest';
      }
    	
    	$scope.logout = function(){
        FirebaseAuthService.auth.$unauth();
        $location.path('/login');
  		}
    },
    link: function(scope, el, attr) {}
  }
});

app.directive('sideMenu', function() {
  return {
    replace: true,
    restrict: 'E',
    templateUrl: '/partials/navigation/side-menu.html',
    controller: function($scope, $element,$location){
      
    },
    link: function(scope, el, attr) {}
  }
});

app.directive('navbarTopLinks', [function() {
  return {
    replace: true,
    restrict: 'E',
    templateUrl: '/partials/navigation/navbar-top-links.html',
    controller: function($scope, $element){},
    link: function(scope, el, attr) {}
  }
}]);

app.directive('eventsDropdown', [function() {
  return {
    replace: true,
    restrict: 'A',
    templateUrl: '/partials/navigation/events-dropdown.html',
    controller: function($scope, $element){},
    link: function(scope, el, attr) {}
  }
}]);

app.directive('openCreateEventModal', [function () {
        return {
            // replace: true,
            restrict: 'A',
            controller: function ($scope, $element, $modal) {
              $scope.items = ['item1', 'item2', 'item3'];
                $scope.open = function() {
                    var modalInstance = $modal.open({
                        templateUrl: '/modals/create_event.html',
                        controller: 'EventCreateCtrl',
                        size: 'lg',
                        resolve: {
                            items: function () {
                                return $scope.items;
                            }
                        }
                    });

                    modalInstance.result.then(function (selectedItem) {
                        $scope.selected = selectedItem;
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                };
            },
            link: function (scope, el, attr) {
                el.on('click', function () {
                  scope.open();
                });
            }
        }
    }]);


