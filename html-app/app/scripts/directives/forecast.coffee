angular.module('weatherjerkApp').directive 'forecast', ->
  restrict: 'E'
  scope:
    data: '='
  controller: ['$scope', ($scope)->
    # $scope.current = $scope.data.current if $scope.data
  ]
  template: """
  <div ng-show="data" class="forecast-data">
    <div class="current">
      <h3>Right Now</h3>
      <forecast-icon data="data.current" size="128"></forecast-icon>
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
    <h3>5-Day Forecast</h3>
    <div class="forecast-day" ng-repeat="forecast in data.forecast">
      <date data="forecast.date"></date>
      <forecast-icon data="forecast"></forecast-icon>
      <table class="temperature">
        <tr class="temp-high">
          <td>High:</td>
          <td>{{forecast.temperature.high.f}}</td>
        </tr>
        <tr class="temp-low">
          <td>Low:</td>
          <td>{{forecast.temperature.low.f}}</td>
        </tr>
      </table>
    </div>
  </div>
  """
  replace: true
