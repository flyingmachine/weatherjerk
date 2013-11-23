angular.module('weatherjerkApp').directive 'forecastForm', ->
  restrict: 'E'
  scope:
    forecasts: '='
    which: '@'
    placeholder: '@'
  controller: ['$scope', '$http', ($scope, $http)->
    $scope.getForecastData = ()->
      $(".forecast-form input").each (i, el)->
        $el = $(el)
        if $(el).val() == ''
          $(el).select()
          false
        else
          true
        
        
      $scope.status = "waiting"
      $http.get("/forecasts/#{encodeURIComponent($scope.forecast)}").then (res)->
        $scope.status = "complete"
        $scope.forecasts[$scope.which] = res.data
        console.log $scope.forecasts[$scope.which]
  ]
  template: """
  <form ng-submit="getForecastData()" class="forecast-form">
    <div>
      <input type="text"
             ng-model="forecast"
             placeholder="{{placeholder}}"/>
      <input type="submit" value="Get Forecast"/>
    </div>
    <activity status="status"></activity>
  </form>
  """
  replace: true