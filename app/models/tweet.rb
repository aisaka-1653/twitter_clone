# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes

  scope :with_user_and_avatar, -> { includes(user: :avatar_attachment) }
  scope :sorted, -> { order(created_at: :desc) }
  scope :following_tweets, ->(user) { where(user_id: user.following_user_ids) }

  def self.feed_for(user)
    following_tweets(user).with_user_and_avatar.sorted
  end
end
