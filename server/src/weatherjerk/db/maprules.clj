(ns weatherjerk.db.maprules
  (:require [weatherjerk.db.query :as db]
            cemerick.friend.credentials)
  (:use [flyingmachine.cartographer.core]
        [weatherjerk.utils]))

(defn ref-count
  [ref-attr]
  #(ffirst (db/q [:find '(count ?c) :where ['?c ref-attr (:db/id %)]])))

(def date-format (java.text.SimpleDateFormat. "yyyy-MM-dd HH:mm:ss Z"))

(defn format-date
  [date]
  (.format date-format date))

(defn sorted-content
  [content-attribute sort-fn]
  #(sort-by sort-fn (weatherjerk.db.query/all content-attribute [:content/author (:db/id %)])))

(def dbid #(or (str->int (:id %)) #db/id[:db.part/user]))

(defmaprules ent->post
  (attr :id :db/id)
  (attr :created-at (comp format-date :post/created-at))
  (attr :topic-id (comp :db/id :post/topic))
  (attr :likers #(map (comp :db/id :like/user) (:like/_post %)))
  (has-one :author
           :rules weatherjerk.db.maprules/ent->user
           :retriever :content/author)
  (has-one :topic
           :rules weatherjerk.db.maprules/ent->topic
           :retriever :post/topic))

(defmaprules ent->user
  (attr :id :db/id)
  (attr :username :user/username)
  (attr :email :user/email)
  (attr :about :user/about)
  (attr :receive-watch-notifications :user/receive-watch-notifications)
  (attr :formatted-about #(md-content (:user/about %)))
  (has-many :topics
            :rules weatherjerk.db.maprules/ent->topic
            :retriever #(weatherjerk.db.query/all :topic/title [:content/author (:db/id %)]))
  (has-many :posts
            :rules weatherjerk.db.maprules/ent->post
            :retriever (weatherjerk.db.maprules/sorted-content :post/content :post/created-at)))

(defmaprules ent->userauth
  (attr :id :db/id)
  (attr :password :user/password)
  (attr :username :user/username)
  (attr :email :user/email))

(defmaprules user->txdata
  (attr :db/id dbid)
  (attr :user/username :username)
  (attr :user/email :email)
  (attr :user/about :about)
  (attr :user/receive-watch-notifications :receive-watch-notifications)
  (attr :user/password #(cemerick.friend.credentials/hash-bcrypt (:password %))))

(defmaprules change-password->txdata
  (attr :db/id #(str->int (:id %)))
  (attr :user/password #(cemerick.friend.credentials/hash-bcrypt (:new-password %))))

(defmaprules post->txdata
  (attr :db/id dbid)
  (attr :post/content :content))
