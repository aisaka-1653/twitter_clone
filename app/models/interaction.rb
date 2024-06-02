# frozen_string_literal: true

class Interaction < ApplicationRecord
  include Notifiable

  belongs_to :tweet
  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :type, inclusion: { in: %w[Like Retweet Bookmark] }

  private

  def notification_not_required?
    user == tweet.user || type == 'Bookmark'
  end

  def notification_sender
    user
  end

  def notification_recipient
    tweet.user
  end
end
