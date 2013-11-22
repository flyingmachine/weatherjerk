'use strict'

angular.module('weatherjerkApp', ['ngResource'])
  .config ($routeProvider)->
    $routeProvider
      .when '/',
        templateUrl: '/views/gloats/new.html',
        controller: 'GloatsNewCtrl'
      .when '/gloats/:id',
        templateUrl: '/views/gloats/show.html',
        controller: 'GloatsShowCtrl'
      .otherwise
        redirectTo: '/'
