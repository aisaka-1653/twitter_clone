# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :users, through: :room_users

  def interlocutor(current_user)
    @interlocutor ||= users.where.not(id: current_user.id).take
  end

  def last_message
    messages.order(created_at: :desc).first
  end
end
