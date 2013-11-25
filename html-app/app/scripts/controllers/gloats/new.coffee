'use strict'
angular.module('weatherjerkApp').controller 'GloatsNewCtrl', ($scope, $http, Gloat) ->
  $ ->
    $(".forecast-form input").first().select()
  # TODO this belongs in a directive
  $scope.selectText = ($event)->
    doc = document
    text = $event.target
    if (doc.body.createTextRange)
      range = doc.body.createTextRange();
      range.moveToElementText(text);
      range.select();
    else if window.getSelection
      selection = window.getSelection();            
      range = doc.createRange();
      range.selectNodeContents(text);
      selection.removeAllRanges();
      selection.addRange(range);
      
  createGloat = ->
    gloat = new Gloat
      gloater_forecast_id: $scope.forecasts.gloater.id
      poor_slob_forecast_id: $scope.forecasts.poorSlob.id
    gloat.$save (g)->
      $scope.gloat = g

  onFilledOut = ->
    if $scope.forecasts.gloater && $scope.forecasts.poorSlob
      $scope.compareForecasts($scope.forecasts.gloater, $scope.forecasts.poorSlob)
      createGloat()
      
  $scope.$watch 'forecasts.gloater', onFilledOut
  $scope.$watch 'forecasts.poorSlob', onFilledOut