angular.module('weatherjerkApp').directive 'forecastIcon', ->
  restrict: 'E'
  scope:
    data: '='
    size: '='
  controller: ['$scope', 'WeatherCode', ($scope, WeatherCode)->
    iconSize = ->
      $scope.size || '64'
    $scope.iconPath = ->
      if $scope.data
        "/images/weather-icons/PNGs_#{iconSize()}x#{iconSize()}/#{WeatherCode[$scope.data.code]}.png"
  ]
  template: """
  <div class="forecast-icon">
    <img ng-src="{{iconPath()}}" />
  </div>
  """
  replace: true
