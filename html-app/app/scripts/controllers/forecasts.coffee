'use strict'
angular.module('weatherjerkApp').controller 'ForecastsCtrl', ($scope) ->
  $scope.classes = (data)->
    _.map data.conditions.keys, (condition)->
      "forecast-#{condition}"
      
  
    
    
  