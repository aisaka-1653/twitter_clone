# frozen_string_literal: true

class Follow < ApplicationRecord
  after_create_commit :create_followed_notification

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  private

  def create_followed_notification
    Notification.create(
      sender: follower,
      recipient: followee,
      notifiable: self
    )
  end
end
