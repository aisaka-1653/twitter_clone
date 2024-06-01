# frozen_string_literal: true

class NotificationsController < ApplicationController
  after_action :update_unread_notifications_to_read

  def index
    @notifications = current_user.received_notifications.includes(sender: { avatar_attachment: :blob },
                                                                  notifiable: %i[
                                                                    tweet follower
                                                                  ]).order(created_at: :desc).page(params[:page])
  end

  private

  def update_unread_notifications_to_read
    @notifications.unread.find_each { |notification| notification.update(checked: true) }
  end
end
