'use strict';
angular.module("weatherjerkApp").factory "Gloat", ["$resource", ($resource) ->
  service = $resource '/gloats/:id', id: '@id'
]