(ns weatherjerk.db.connection
  (:require [environ.core :refer (env)]
            [korma.db :refer (postgres defdb)]))

(def db-config (postgres (get-in env [:app :db])))
(defdb db db-config)