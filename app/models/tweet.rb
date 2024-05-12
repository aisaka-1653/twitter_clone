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

  scope :with_preload_associations, lambda {
    includes(
      image_attachment: :blob,
      user: { avatar_attachment: :blob },
      interactions: [],
      likes: [],
      retweets: [],
      bookmarks: []
    )
  }
  scope :sorted, -> { order(created_at: :desc) }

  validates :content, length: { maximum: 140 }
  validate :require_content_or_image

  def find_user_interaction(user, type)
    interactions.find { |interaction| interaction.user_id == user.id && interaction.type == type }
  end

  def self.feed_for(user)
    following_tweets(user)
      .with_preload_associations
      .sorted
  end

  def self.preload_user_and_avatar(tweets)
    tweets.with_preload_associations.order('interactions.created_at DESC')
  end

  def self.with_retweets
    joins("LEFT JOIN interactions AS retweets ON tweets.id = retweets.tweet_id AND retweets.type = 'Retweet'")
      .select(
        'tweets.id',
        'tweets.user_id',
        'tweets.content',
        'MAX(COALESCE(retweets.created_at, tweets.created_at)) AS created_at'
      )
      .group('tweets.id')
      .with_preload_associations
      .order('created_at DESC')
  end

  def self.with_retweets_by_user(user)
    with_retweets.where('tweets.user_id = ? or retweets.user_id = ?', user.id, user.id)
  end

  def self.following_tweets(user)
    with_retweets.where('tweets.user_id IN (?) or retweets.user_id IN (?)', user.following_user_ids,
                        user.following_user_ids)
  end

  private

  def require_content_or_image
    return unless content.blank? && !image.attached?

    errors.add(:base, '文字か画像のどちらかは入力必須です')
  end
end
