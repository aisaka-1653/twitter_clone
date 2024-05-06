# frozen_string_literal: true

class Interaction < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :type, inclusion: { in: %w[Like Retweet Bookmark] }
end
