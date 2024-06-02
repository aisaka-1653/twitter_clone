# frozen_string_literal: true

class Comment < ApplicationRecord
  include Notifiable

  belongs_to :tweet, optional: true
  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  scope :sorted, -> { order(created_at: :desc) }

  validates :content, presence: true
  validates :content, length: { maximum: 140 }

  private

  def notification_not_required?
    user == tweet.user
  end

  def notification_sender
    user
  end

  def notification_recipient
    tweet.user
  end
end
