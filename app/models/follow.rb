# frozen_string_literal: true

class Follow < ApplicationRecord
  include Notifiable

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
  has_one :notification, as: :notifiable, dependent: :destroy

  private

  def notification_not_required?
    false
  end

  def notification_sender
    follower
  end

  def notification_recipient
    followee
  end
end
