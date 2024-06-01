# frozen_string_literal: true

class Comment < ApplicationRecord
  after_create_commit :create_comment_notification

  belongs_to :tweet, optional: true
  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  scope :sorted, -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :content, length: { maximum: 140 }

  private

  def create_comment_notification
    return if user_id == tweet.user.id
    Notification.create(
      sender_id: user_id,
      recipient: tweet.user,
      notifiable: self
    )
  end
end
