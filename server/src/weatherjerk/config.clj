(ns weatherjerk.config
  (:use environ.core))

(def conf {:html-paths ["html-app"
                        "../html-app/app"
                        "../html-app/.tmp"]
           :datomic {:db-uri "datomic:free://localhost:4334/gp2"
                     :test-uri "datomic:mem://gp2"}
           :weather-api-key (env :weather-api-key)})

(defn config
  [& keys]
  (get-in conf keys))
