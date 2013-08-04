'use strict'
angular.module('weatherjerkApp').controller 'LocationsCtrl', ($scope, $http) ->
  $scope.getLocationData = ->
    $http.get("/locations/#{encodeURIComponent($scope.location)}").then (data)->
      $scope.locationData = data
    
    
  