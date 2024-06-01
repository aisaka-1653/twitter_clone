class NotificationsController < ApplicationController
  after_action :update_unread_notifications_to_read

  def index
    @notifications = current_user.received_notifications.includes(sender: { avatar_attachment: :blob }, notifiable: [:tweet, :follower]).order(created_at: :desc).page(params[:page])
  end
  
  private

  def update_unread_notifications_to_read
    @notifications.unread.update_all(checked: true)
  end
end
