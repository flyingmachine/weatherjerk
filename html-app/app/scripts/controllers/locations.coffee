'use strict'
angular.module('weatherjerkApp').controller 'LocationsCtrl', ($scope, $http) ->
  $scope.classes = (data)->
    _.map data.conditions.keys, (condition)->
      "forecast-#{condition}"
  $scope.getLocationData = ->
    $http.get("/locations/#{encodeURIComponent($scope.location)}").then (res)->
      $scope.locationData = res.data
    
    
  