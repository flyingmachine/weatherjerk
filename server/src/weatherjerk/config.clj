(ns weatherjerk.config
  (:use environ.core))

(def conf {:html-paths ["html-app"
                        "../html-app/app"
                        "../html-app/.tmp"]
           :weather-api-key (env :weather-api-key)})

(defn config
  [& keys]
  (get-in conf keys))
