(ns weatherjerk.controllers.gloats
  (:require [liberator.core :refer [defresource]]
            [korma.core :refer :all]
            [weatherjerk.db.entities :as e]
            [weatherjerk.db.crud :as crud]
            [weatherjerk.controllers.shared :refer :all]))

(defresource show
  :available-media-types ["application/json"]
  :handle-ok (fn [_] ))

(defn update!*
  [params]
  {:record (crud/update! e/gloats {:id (:id params)} params)})

(defresource update! [params]
  :allowed-methods [:put :post]
  :available-media-types ["application/json"]
  :put! (fn [_] (update!* params))
  :post! (fn [_] (update!* params))
  :handle-ok record-in-ctx)

(defresource create! [params]
  :allowed-methods [:post]
  :available-media-types ["application/json"]
  :post! (fn [_] {:record (select-keys (crud/create! e/gloats params)
                                      [:id])})
  :handle-created record-in-ctx)