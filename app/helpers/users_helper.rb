module UsersHelper
  def current_user?(user)
    current_user == user
  end

  def username_present?(comment)
    comment.respond_to?(:username) && comment.tweet_id.present?
  end
end
