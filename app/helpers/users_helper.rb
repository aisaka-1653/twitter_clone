# frozen_string_literal: true

module UsersHelper
  def liked_by_current_user?(tweet)
    tweet.likes.any? { |like| like.user_id == current_user.id }
  end

  def retweeted_by_current_user?(tweet)
    tweet.retweets.any? { |retweet| retweet.user_id == current_user.id }
  end

  def bookmarked_by_current_user?(tweet)
    tweet.bookmarks.any? { |bookmark| bookmark.user_id == current_user.id }
  end
end
