'use strict';

var app = angular.module('Tmdb', []);

app.service('TmdbService', ['$q', '$http', 'tmdbConfig',
  function($q, $http, tmdbConfig) {
    var api = tmdbConfig.api;
    var service = this;
    if(angular.isUndefined(service.upcomingMovies)){
      service.upcomingMovies = {}
    }

    if(angular.isUndefined(service.popularMovies)){
      service.popularMovies = {}
    }

    service.getUpcomingMovies = function(page){
      var def = $q.defer();
      var page = page || 1;

      if(angular.isUndefined(service.upcomingMovies[page])){
        console.log("we do not have upcoming movies");
        getUpcomingMoviesRemote(page).
          success(function(data){
            //@todo cache the data
            console.log("caching upcoming movies");
            service.upcomingMovies[page] = data;
            def.resolve(service.upcomingMovies[page]); 
          }).
          error(function(error){
            console.log("error: "+error);
            def.reject(error);
            return def.promise;
          });        
      } else {
        console.log("we already have upcoming movies");
        def.resolve(service.upcomingMovies[page]); 
      }
      return def.promise;
    }

    function getUpcomingMoviesRemote(page){
      var page = page || 1;
      var uri = '/movie/upcoming';
      var url = buildUrl(uri);
      return $http.get(url+'&page='+page)
    }

    service.getPopularMovies = function(page){
      var def = $q.defer();
      var page = page || 1;

      if(angular.isUndefined(service.popularMovies[page])){
        console.log("we do not have popular movies");
        getPopularMoviesRemote(page).
          success(function(data){
            //@todo cache the data
            console.log("caching popular movies");
            service.popularMovies[page] = data;
            def.resolve(service.popularMovies[page]); 
          }).
          error(function(error){
            console.log("error: "+error);
            def.reject(error);
            return def.promise;
          });        
      } else {
        console.log("we already have popular movies");
        def.resolve(service.popularMovies[page]); 
      }
      return def.promise;
    }

    function getPopularMoviesRemote(page){
      var page = page || 1;
      var uri = '/movie/popular';
      var url = buildUrl(uri);
      return $http.get(url+'&page='+page)
    }

    function buildUrl(uri){
      var prefix = 'https://api.themoviedb.org/3';
      return prefix + uri + '?language=en&include_image_language=en&api_key=' + api;
    }

    return service;
  }
]);