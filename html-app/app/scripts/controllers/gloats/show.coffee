'use strict'
angular.module('weatherjerkApp').controller 'GloatsShowCtrl', ($scope, $routeParams, Gloat) ->
  Gloat.get id: $routeParams.id, (gloat)->
    $scope.gloat = gloat
    $scope.compareForecasts($scope.gloat.forecasts.gloater, $scope.gloat.forecasts.poorSlob)

  onFilledOut = ->
    if $scope.forecasts.gloater && $scope.forecasts.poorSlob
      $scope.compareForecasts($scope.forecasts.gloater, $scope.forecasts.poorSlob)
      
  $scope.$watch 'forecasts.gloater', onFilledOut
  $scope.$watch 'forecasts.poorSlob', onFilledOut