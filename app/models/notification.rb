class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(checked: false)}

  def unread?
    !checked
  end
end
