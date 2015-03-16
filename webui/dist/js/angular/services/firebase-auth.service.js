'use strict';

var app = angular.module('FirebaseAuth', [
    'firebase'
]);

app.service('FirebaseAuthService', ['$rootScope', '$firebaseAuth', 'firebaseConfig',
  function($rootScope, $firebaseAuth, firebaseConfig) {
    var ref = new Firebase(firebaseConfig.url());
    
    this.auth = $firebaseAuth(ref);

    this.saveUser = function(authData){
    	if(angular.isUndefined(authData) || authData == null || authData.provider != 'facebook'){
    		return false;
    	}
    	var user_id = authData.facebook.id;
    	ref.child('users').child(user_id).once('value', function(snap) {
       		var user_exists = snap.val();
       		if(user_exists){
       			console.log("user exists");
       		} else {
       			console.log('user does not exist');
       			var user = {
		    		facebook_id: authData.facebook.id,
		    		name: authData.facebook.displayName,
		    		profile_image_url: 'http://graph.facebook.com/'+user_id+'/picture?type=large',
		    		friends: []
		    	};
		    	ref.child('users').child(user_id).set(user);
       		}
   		});    	
    };
  }
]);