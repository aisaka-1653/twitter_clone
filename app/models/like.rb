# frozen_string_literal: true

class Like < Interaction
  belongs_to :tweet
  belongs_to :user
end
