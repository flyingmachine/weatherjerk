angular.module('weatherjerkApp').directive 'activity', ->
  restrict: 'EA'
  scope:
    status: '='
  template: "<div class=\"activity\" ng-show=\"status == 'waiting'\">
      <img src='/images/ajax-loader.gif' />
    </div>"
  replace: true
