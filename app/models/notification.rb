class Notification < ApplicationRecord
  belongs_to :sender
  belongs_to :recipient
  belongs_to :notifiable, polymorphic: true
end
