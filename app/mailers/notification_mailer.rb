# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  helper NotificationsHelper

  def notification_mail(notification)
    @notification = notification
    mail(to: @notification.recipient.email, subject: 'twitter-clone通知')
  end
end
