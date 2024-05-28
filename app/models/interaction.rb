# frozen_string_literal: true

class Interaction < ApplicationRecord
  after_create_commit :create_interaction_notification

  belongs_to :tweet
  belongs_to :user

  validates :type, inclusion: { in: %w[Like Retweet Bookmark] }

  private

  def create_interaction_notification
    return if user_id == tweet.user.id
    Notification.create(
      sender_id: user_id,
      recipient: tweet.user,
      notifiable: self
    )
  end
end
