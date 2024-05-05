# frozen_string_literal: true

class TweetsController < ApplicationController
  def create
    @tweet = current_user.tweets.build(tweet_params)
    flash[:danger] = @tweet.errors.full_messages[0] unless @tweet.save
    redirect_to root_path
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = current_user.comments.new
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
