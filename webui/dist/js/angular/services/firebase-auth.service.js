'use strict';

var app = angular.module('FirebaseAuth', [
    'firebase'
]);

app.service('FirebaseAuthService', ['$rootScope', '$firebaseAuth', 'firebaseConfig',
  function($rootScope, $firebaseAuth, firebaseConfig) {
    var ref = new Firebase(firebaseConfig.url());
    this.auth = $firebaseAuth(ref);
  }
]);