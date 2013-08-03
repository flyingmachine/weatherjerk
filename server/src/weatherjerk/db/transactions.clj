(ns weatherjerk.db.transactions
  (:require [datomic.api :as d]
            [weatherjerk.db.maprules :as mr]
            [weatherjerk.db.query :as db]
            [weatherjerk.models.mailer :as mailer]
            [flyingmachine.cartographer.core :as c])
  (:use weatherjerk.utils))

(defn create-post
  [params]
  (let [{:keys [topic-id author-id]} params
        post-tempid (d/tempid :db.part/user -1)
        now (now)
        post (remove-nils-from-map {:post/content (:content params)
                                    :post/topic topic-id
                                    :post/created-at now
                                    :content/author author-id
                                    :db/id post-tempid})
        watches (db/all :watch/topic [:watch/topic topic-id])
        result (db/t [post
                      {:db/id topic-id :topic/last-posted-to-at now}
                      [:increment-watch-count topic-id author-id]])]

    {:result result
     :tempid post-tempid}))

(defn update-post
  [params]
  (fn [_] (db/t [(c/mapify params mr/post->txdata)])))

(defn create-user
  [params]
  (let [params (remove-nils-from-map (c/mapify params mr/user->txdata))]
    {:result (db/t [params])
     :tempid (:db/id params)}))
