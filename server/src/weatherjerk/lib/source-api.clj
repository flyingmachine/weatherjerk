(ns weatherjerk.lib.source-api
  (:require [org.httpkit.client :as http]
            [weatherjerk.config :refer [config]]
            [clojure.data.json :as json]))

(def url "http://api.worldweatheronline.com/free/v1/weather.ashx")
(defn options
  [params]
  {:timeout 200
   :query-params (merge {:key (config :weather-api-key)
                         :format "json"}
                        params)})

(defn location-forecast
  [location]
  (-> @(http/get url (options {:q location}))
      :body
      json/read-str
      (get "data")))