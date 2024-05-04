# frozen_string_literal: true

module TweetsHelper
  def tweet?(tweet)
    tweet.instance_of?(Tweet)
  end

  def image_attached?(tweet)
    tweet.respond_to?(:image) && tweet.image.attached?
  end
end
