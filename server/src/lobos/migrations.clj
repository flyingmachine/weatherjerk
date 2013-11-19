(ns lobos.migrations
  (:refer-clojure :exclude [alter drop
                            bigint boolean char double float time])
  (:use (lobos [migration :only [defmigration]] core schema
               config helpers)))

(defmigration add-gloats-table
  (up [] (create
          (tbl :moosh
               (text :words)
               (text :response)
               (refer-to :user))))
  (down [] (drop (table :moosh))))

(defmigration add-forecasts-table
  (up [] (create
          (tbl :user_session
               (varchar :key 255 :unique)
               (text :data)))
      (create (index :user_session [:key])))
  (down [] (drop (table :user_session))))