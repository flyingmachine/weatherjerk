'use strict'
angular.module('weatherjerkApp').controller 'ForecastsCtrl', ($scope, $http) ->
  $scope.classes = (data)->
    _.map data.conditions.keys, (condition)->
      "forecast-#{condition}"
  $scope.getForecastData = ->
    $http.get("/forecasts/#{encodeURIComponent($scope.forecast)}").then (res)->
      $scope.forecastData = res.data
      console.log $scope.forecastData
    
    
  