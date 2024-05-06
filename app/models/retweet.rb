# frozen_string_literal: true

class Retweet < Interaction
  belongs_to :tweet
  belongs_to :user
end
