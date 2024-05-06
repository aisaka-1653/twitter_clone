# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = tweet.comments.build(comment_params)
    comment.assign_user_and_username(current_user)

    flash[:danger] = comment.errors.full_messages[0] unless comment.save
    redirect_to tweet_url(tweet)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
