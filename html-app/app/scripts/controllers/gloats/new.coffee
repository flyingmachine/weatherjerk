'use strict'
angular.module('weatherjerkApp').controller 'NewGloatsCtrl', ($scope, $http) ->
  $scope.settings = unit: "f"