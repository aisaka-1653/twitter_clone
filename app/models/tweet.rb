# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :interactions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # ツイートが削除されてもプロフィール画面では表示する
  has_many :comments, dependent: :nullify
  has_one_attached :image

  scope :with_user_and_avatar, -> { includes(user: :avatar_attachment) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :following_tweets, ->(user) { where(user_id: user.following_user_ids) }

  validates :content, length: { maximum: 140 }
  validate :require_content_or_image

  def find_user_interaction(user, type)
    interactions.find_by(user_id: user.id, type:)
  end

  def self.feed_for(user)
    following_tweets(user).with_user_and_avatar.sorted
  end

  def self.preload_user_and_avatar(tweets)
    tweets.with_user_and_avatar.sorted
  end

  def self.with_retweets
    Tweet.select('tweets.id, tweets.user_id, tweets.content, COALESCE(retweets.created_at, tweets.created_at) AS created_at')
      .joins("LEFT JOIN interactions AS retweets ON tweets.id = retweets.tweet_id AND retweets.type = 'Retweet'")
      .with_attached_image.includes(image_attachment: :blob)
      .includes(user: { avatar_attachment: :blob })
      .includes(:interactions)
      .order('created_at DESC')
  end

  def self.with_retweets_by_user(user)
    Tweet.select('tweets.id, tweets.user_id, tweets.content, COALESCE(retweets.created_at, tweets.created_at) AS created_at')
      .joins("LEFT JOIN interactions AS retweets ON tweets.id = retweets.tweet_id AND retweets.type = 'Retweet' AND retweets.user_id = #{user.id}")
      .where("tweets.user_id = ?", user.id)
      .with_attached_image.includes(image_attachment: :blob)
      .includes(user: { avatar_attachment: :blob })
      .includes(:interactions, :likes, :retweets, :bookmarks)
      .order('created_at DESC')
  end

  private

  def require_content_or_image
    return unless content.blank? && !image.attached?

    errors.add(:base, '文字か画像のどちらかは入力必須です')
  end
end
