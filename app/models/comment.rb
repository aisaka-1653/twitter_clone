# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :tweet, optional: true
  belongs_to :user

  scope :sorted, -> { order(created_at: :desc) }
end
