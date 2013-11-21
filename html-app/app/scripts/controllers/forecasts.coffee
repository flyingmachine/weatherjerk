'use strict'
angular.module('weatherjerkApp').controller 'ForecastsCtrl', ($scope, $http) ->

  $scope.classes = (data)->
    _.map data.conditions.keys, (condition)->
      "forecast-#{condition}"
      
  $scope.getForecastData = (which)->
    $scope.status = "waiting"
    $http.get("/forecasts/#{encodeURIComponent($scope.forecast)}").then (res)->
      $scope.status = "complete"
      $scope.forecasts[which] = res.data
      console.log $scope.forecasts[which]
    
    
  