# frozen_string_literal: true

module TweetsHelper
  def image_attached?(tweet)
    tweet.image.attached?
  end
end
