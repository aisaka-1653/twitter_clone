class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.sorted.page(params[:tweets_page])
    @likes = Tweet.preload_user_and_avatar(@user.liked_tweets).page(params[:likes_page])
    @retweets = Tweet.preload_user_and_avatar(@user.retweeted_tweets).page(params[:retweets_page])
    @comments = @user.comments.sorted.page(params[:comments_page])
  end

  def edit
  end
end
