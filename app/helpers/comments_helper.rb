# frozen_string_literal: true

module CommentsHelper
  def sender(comment)
    "@#{comment.user.username}"
  end

  def receiver(comment)
    "@#{comment.tweet.user.username}"
  end
end
