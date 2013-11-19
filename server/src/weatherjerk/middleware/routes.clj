(ns weatherjerk.middleware.routes
  (:require compojure.route
            compojure.handler
            [ring.util.response :as resp]
            [weatherjerk.controllers.locations :as locations]
            [weatherjerk.controllers.users :as users]
            [weatherjerk.controllers.session :as session]
            [cemerick.friend :as friend])
  (:use [compojure.core :as compojure.core :only (GET PUT POST DELETE ANY defroutes)]
        weatherjerk.config))


(defmacro route
  [method path handler]
  `(~method ~path {params# :params}
            (~handler params#)))

(defmacro authroute
  [method path handler]
  (let [params (quote params)]
    `(~method ~path {:keys [~params] :as req#}
              (~handler ~params (friend/current-authentication req#)))))

(defroutes routes
  ;; Serve up angular app
  (apply compojure.core/routes
         (map #(compojure.core/routes
                (compojure.route/files "/" {:root %})
                (compojure.route/resources "/" {:root %}))
              (reverse (config :html-paths))))
  (apply compojure.core/routes
         (map (fn [response-fn]
                (GET "/" [] (response-fn "index.html" {:root "html-app"})))
              [resp/file-response resp/resource-response]))
    
  ;; Locations
  (route GET "/forecasts/:location" forecasts/show)

  (compojure.route/not-found "Sorry, there's nothing here."))
