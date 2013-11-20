(ns weatherjerk.db.crud
  (:require [korma.core :refer :all]
            [weatherjerk.db.entities :as e]
            [flyingmachine.webutils.utils :refer :all]))

(defn create!
  [entity attributes]
  (insert entity (values attributes)))

(defn update!
  [entity conditions attributes]
  (let [attributes (dissoc attributes :id)]
    (update entity
            (set-fields attributes)
            (where (str->int conditions :id)))))

(defn destroy!
  [entity conditions]
  (delete entity
          (where (str->int conditions :id))))

(defn by-id
  [entity id]
  (first (-> (select* entity)
             (where* {:id (str->int id)}))))

(defn one
  [entity conditions]
  (-> (select* entity)
      (where* conditions)))

(defmacro all
  [entity & clauses]
  `(select ~entity
           ~@clauses
           (order :created_on :DESC)))