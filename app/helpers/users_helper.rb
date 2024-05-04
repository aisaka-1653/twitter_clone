# frozen_string_literal: true

module UsersHelper
  def username_present?(tweet)
    tweet.respond_to?(:username) && tweet.tweet_id.present?
  end

  def tweet?(tweet)
    tweet.instance_of?(Tweet)
  end

  def liked_by_current_user?(tweet)
    tweet.likes.exists?(user_id: current_user.id)
  end

  def retweeted_by_current_user?(tweet)
    tweet.retweets.exists?(user_id: current_user.id)
  end

  def bookmarked_by_current_user?(tweet)
    tweet.bookmarks.exists?(user_id: current_user.id)
  end
end
