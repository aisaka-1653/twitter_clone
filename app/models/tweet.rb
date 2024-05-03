# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # ツイートが削除されてもプロフィール画面では表示する
  has_many :comments, dependent: :nullify
  has_one_attached :image

  scope :with_user_and_avatar, -> { includes(user: :avatar_attachment) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :following_tweets, ->(user) { where(user_id: user.following_user_ids) }

  def self.feed_for(user)
    following_tweets(user).with_user_and_avatar.sorted
  end

  def self.preload_user_and_avatar(tweets)
    tweets.with_user_and_avatar.sorted
  end
end
