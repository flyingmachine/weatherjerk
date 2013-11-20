(ns weatherjerk.controllers.forecasts
  (:require [weatherjerk.lib.source-api :as api]
            [weatherjerk.models.forecasts :as forecasts]
            [liberator.core :refer [defresource]]))

(defresource show [params]
  :available-media-types ["application/json"]
  :handle-ok (forecasts/forecast (:location params)))

