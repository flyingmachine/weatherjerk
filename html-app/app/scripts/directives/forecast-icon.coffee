angular.module('weatherjerkApp').directive 'forecastIcon', ->
  restrict: 'E'
  scope:
    data: '=data'
  controller: ['$scope', 'WeatherCode', ($scope, WeatherCode)->
    $scope.iconPath = ->
      if $scope.data
        "/images/weather-icons/PNGs_64x64/#{WeatherCode[$scope.data.code].dayIcon}.png"
    console.log $scope.data if $scope
    console.log $scope.iconPath()
  ]
  template: """
  <div class="forecast-icon">
    <img src="{{iconPath()}}" />
  </div>
  """
  replace: true
