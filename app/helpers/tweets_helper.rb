# frozen_string_literal: true

module TweetsHelper
  def image_attached?(tweet)
    tweet.image.attached?
  end

  def likes_count(tweet)
    count = tweet.likes.count
    return unless count.positive?

    content_tag(:span, count, class: 'text-secondary small')
  end
end
