# frozen_string_literal: true

module TweetsHelper
  def image_attached?(tweet)
    tweet.image.attached?
  end

  def likes_count(tweet)
    count = tweet.likes.size
    return unless count.positive?

    content_tag(:span, count, class: 'text-secondary small')
  end

  def retweets_count(tweet)
    count = tweet.retweets.size
    return unless count.positive?

    content_tag(:span, count, class: 'text-secondary small')
  end

  def bookmarks_count(tweet)
    count = tweet.bookmarks.size
    return unless count.positive?

    content_tag(:span, count, class: 'text-secondary small')
  end
end
