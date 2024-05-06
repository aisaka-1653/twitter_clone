# frozen_string_literal: true

class Bookmark < Interaction
  belongs_to :tweet
  belongs_to :user
end
