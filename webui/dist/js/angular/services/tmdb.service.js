'use strict';

var app = angular.module('Tmdb', []);

app.service('TmdbService', ['$http', 'tmdbConfig',
  function($http, tmdbConfig) {
    var api = tmdbConfig.api;
    
    this.fetchUpcomingMovies = function(){
      var uri = '/movie/upcoming';
      var url = buildUrl(uri);
       return $http.get(url)
    }

    function buildUrl(uri){
      var prefix = 'https://api.themoviedb.org/3';
      return prefix + uri + '?language=en&include_image_language=en&api_key=' + api;
    }
  }
]);