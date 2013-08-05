angular.module('weatherjerkApp').directive 'forecast', ->
  restrict: 'E'
  scope:
    data: '='
  controller: ['$scope', ($scope)->
    # $scope.current = $scope.data.current if $scope.data
  ]
  template: """
  <div ng-show="data" class="comparison">
    <div class="current">
      <forecast-icon data="data.current" size="256"></forecast-icon>
      <table>
        <tr>
          <td>Temperature</td>
          <td>{{data.current.temperature.f}}&deg;F / {{data.current.temperature.c}}&deg;C</td>
        </tr>
        <tr>
          <td>Humidity</td>
          <td>{{data.current.humidity}}%</td>
        </tr>
      </table>
    </div>
    <div class="forecast" ng-repeat="forecast in data.forecast">
      <forecast-icon data="forecast"></forecast-icon>
    </div>
  </div>
  """
  replace: true
