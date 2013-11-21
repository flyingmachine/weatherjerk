angular.module('weatherjerkApp').directive 'forecast', ->
  restrict: 'E'
  scope:
    data: '='
  controller: ['$scope', ($scope)->
    $scope.settings = $scope.$parent.settings

    $scope.sign = (v)->
      if $scope.data
        if v > 0
          "+#{v.toFixed(0)}"
        else
          v.toFixed(0)
    
    $scope.ct = (f, hl)->
      if $scope.data && f.comparison
        if hl
          $scope.sign(f.comparison.temperature[hl][$scope.settings.unit])
        else
          $scope.sign(f.comparison.temperature[$scope.settings.unit])
        
    $scope.temperature = (t)->
      if $scope.data
        "#{t[$scope.settings.unit]}°#{$scope.settings.unit}"
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
          <td>{{temperature(data.current.temperature)}}</td>
          <td class='comparison'>{{ct(data.current)}}</td>
        </tr>
        <tr>
          <td>Humidity</td>
          <td>{{data.current.humidity}}%</td>
          <td class='comparison'>{{sign(data.current.comparison.humidity)}}</td>
        </tr>
      </table>
    </div>
    <h3>4-Day Forecast</h3>
    <div class="forecast-day" ng-repeat="forecast in data.forecast">
      <date data="forecast.date"></date>
      <forecast-icon data="forecast"></forecast-icon>
      <table class="temperature">
        <tr class="temp-high">
          <td>High:</td>
          <td>{{temperature(forecast.temperature.high)}}</td>
          <td class='comparison'>{{ct(forecast, 'high')}}</td>
        </tr>
        <tr class="temp-low">
          <td>Low:</td>
          <td>{{temperature(forecast.temperature.low)}}</td>
          <td class='comparison'>{{ct(forecast, 'low')}}</td>
        </tr>
      </table>
    </div>
  </div>
  """
  replace: true
