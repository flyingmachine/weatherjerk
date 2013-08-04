(ns weatherjerk.controllers.locations
  (:require [weatherjerk.lib.source-api :as api]
            [liberator.core :refer [defresource]]))

(defresource show [params]
  :available-media-types ["application/json"]
  :handle-ok (api/location-data (:location params)))
