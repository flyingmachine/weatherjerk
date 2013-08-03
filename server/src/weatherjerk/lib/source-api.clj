(ns weatherjerk.lib.source-api
  (:require [org.httpkit.client :as http]))

(def url "http://api.worldweatheronline.com/free/v1/weather.ashx")

(defn location-forecast
  [location]
  )