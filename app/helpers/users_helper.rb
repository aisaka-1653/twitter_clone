# frozen_string_literal: true

module UsersHelper
  def current_user?(user)
    current_user == user
  end

  def username_present?(tweet)
    tweet.respond_to?(:username) && tweet.tweet_id.present?
  end

  def tweet?(tweet)
    tweet.instance_of?(Tweet)
  end

  def liked_by_current_user?(tweet)
    tweet.respond_to?(:likes) && tweet.likes.exists?(user_id: current_user.id)
  end

  def retweeted_by_current_user?(tweet)
    tweet.respond_to?(:retweets) && tweet.retweets.exists?(user_id: current_user.id)
  end

  def bookmarked_by_current_user?(tweet)
    tweet.respond_to?(:bookmarks) && tweet.bookmarks.exists?(user_id: current_user.id)
  end
end
