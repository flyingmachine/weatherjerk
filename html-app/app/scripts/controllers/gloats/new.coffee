'use strict'
angular.module('weatherjerkApp').controller 'NewGloatsCtrl', ($scope, $http, Gloat) ->
  $scope.settings = unit: "f"
  $scope.forecasts =
    gloater: null
    poorSlob: null

  $scope.gloat = null

  compareTemperatures = (t1, t2)->
    c: t1.c - t2.c
    f: t1.f - t2.f

  compare = (f1, f2)->
    f1.current.comparison =
      temperature: compareTemperatures(f1.current.temperature, f2.current.temperature)
      humidity: f1.current.humidity - f2.current.humidity
    _.each f1.forecast, (day, i)->
      day.comparison =
        temperature:
          high: compareTemperatures(day.temperature.high, f2.forecast[i].temperature.high)
          low: compareTemperatures(day.temperature.low, f2.forecast[i].temperature.low)

  compareForecasts = (f1, f2)->
    compare(f1, f2)
    compare(f2, f1)

  onFilledOut = ->
    if $scope.forecasts.gloater && $scope.forecasts.poorSlob
      compareForecasts($scope.forecasts.gloater, $scope.forecasts.poorSlob)
      createGloat()

  createGloat = ->
    gloat = new Gloat
      gloater_forecast_id: $scope.forecasts.gloater.id
      poor_slob_forecast_id: $scope.forecasts.poorSlob.id
    gloat.$save (g)->
      $scope.gloat = g

  $scope.$watch 'forecasts.gloater', onFilledOut
  $scope.$watch 'forecasts.poorSlob', onFilledOut