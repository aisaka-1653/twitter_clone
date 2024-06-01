# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_notification
  end

  def create_notification
    return if notification_not_required?

    Notification.create(
      sender: notification_sender,
      recipient: notification_recipient,
      notifiable: self
    )
  end

  private

  def notification_not_required?
    raise NotImplementedError, "#{self.class}は#{__method__}メソッドを実装する必要があります"
  end

  def notification_sender
    raise NotImplementedError, "#{self.class}は#{__method__}メソッドを実装する必要があります"
  end

  def notification_recipient
    raise NotImplementedError, "#{self.class}は#{__method__}メソッドを実装する必要があります"
  end
end
