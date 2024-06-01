class Notification < ApplicationRecord
  after_create_commit :send_notification_mail

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(checked: false)}

  def unread?
    !checked
  end

  private

  def send_notification_mail
    NotificationMailer.notification_mail(self).deliver_now
  end
end
