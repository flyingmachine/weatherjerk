angular.module('weatherjerkApp').directive 'date', ->
  restrict: 'EA'
  scope:
    date: '=data'
  controller: ['$scope', ($scope)->
    $scope.formatDateTime = (date)->
      moment(date).format("ddd MMM D, YYYY")
    
  ]
  template: "<div class='date'>{{formatDateTime(date)}}</div>"
  replace: true
