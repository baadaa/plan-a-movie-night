'use strict';

var app = angular.module('Events', [
  'firebase'
]);

app.service('EventService', ['$q', 'firebaseConfig', '$firebaseObject',
  function($q, firebaseConfig, $firebaseObject) {
    var ref = new Firebase(firebaseConfig.url());
    var service = this;
    var eventObj = {
      id: null,
      title: null,
      body: null,
      creator_id: null,
      event_date: null,
      location: null,
      invitees: [],
      created: null,
      modified: null
    };

    var inviteeObj = {
      event_id: null,
      user_id: null,
      status: null,
      created: null,
      modified: null
    };

    service.create = function(title, body, creator_id, event_date, location){
      var timestamp = Math.round((new Date()).getTime() / 1000);
      
      //create the event
      var event = eventObj;
      event.title = title;
      event.body = body;
      event.creator_id = creator_id;
      event.event_date = event_date;
      event.location = location;
      event.created = timestamp;
      event.modified = timestamp;

      //save the event
      event.id = ref.child('events').push().set(event).key();

      //invite the creator to the event
      var invite = inviteeObj;
      invite.event_id = event.id;
      invite.user_id = event.creator_id;
      invite.status = 'Going';
      invite.created = timestamp;
      invite.modified = timestamp;

      //save the creator as an invitee
      ref.child('invitees').push(invite);
      event.invitees.push(invite);

      return event;
    }
    
    //the local user's events
    // service.events = ref.orderByChild('invitees').on('value', function(snapshot) {
    //   console.log(snapshot.val());
    // }, function (errorObject) {
    //   console.log("The read failed: " + errorObject.code);
    // });
    // if(angular.isUndefined(service.upcomingMovies)){
    //   service.upcomingMovies = {}
    // }

    // if(angular.isUndefined(service.popularMovies)){
    //   service.popularMovies = {}
    // }

    // service.getUpcomingMovies = function(page){
    //   var def = $q.defer();
    //   var page = page || 1;

    //   if(angular.isUndefined(service.upcomingMovies[page])){
    //     console.log("we do not have upcoming movies");
    //     getUpcomingMoviesRemote(page).
    //       success(function(data){
    //         //@todo cache the data
    //         console.log("caching upcoming movies");
    //         service.upcomingMovies[page] = data;
    //         def.resolve(service.upcomingMovies[page]); 
    //       }).
    //       error(function(error){
    //         console.log("error: "+error);
    //         def.reject(error);
    //         return def.promise;
    //       });        
    //   } else {
    //     console.log("we already have upcoming movies");
    //     def.resolve(service.upcomingMovies[page]); 
    //   }
    //   return def.promise;
    // }

    // function getUpcomingMoviesRemote(page){
    //   var page = page || 1;
    //   var uri = '/movie/upcoming';
    //   var url = buildUrl(uri);
    //   return $http.get(url+'&page='+page)
    // }

    // service.getPopularMovies = function(page){
    //   var def = $q.defer();
    //   var page = page || 1;

    //   if(angular.isUndefined(service.popularMovies[page])){
    //     console.log("we do not have popular movies");
    //     getPopularMoviesRemote(page).
    //       success(function(data){
    //         //@todo cache the data
    //         console.log("caching popular movies");
    //         service.popularMovies[page] = data;
    //         def.resolve(service.popularMovies[page]); 
    //       }).
    //       error(function(error){
    //         console.log("error: "+error);
    //         def.reject(error);
    //         return def.promise;
    //       });        
    //   } else {
    //     console.log("we already have popular movies");
    //     def.resolve(service.popularMovies[page]); 
    //   }
    //   return def.promise;
    // }

    // function getPopularMoviesRemote(page){
    //   var page = page || 1;
    //   var uri = '/movie/popular';
    //   var url = buildUrl(uri);
    //   return $http.get(url+'&page='+page)
    // }

    // function buildUrl(uri){
    //   var prefix = 'https://api.themoviedb.org/3';
    //   return prefix + uri + '?language=en&include_image_language=en&api_key=' + api;
    // }

    return service;
  }
]);