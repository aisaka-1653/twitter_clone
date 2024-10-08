# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @all_tweets = Tweet.with_retweets.page(params[:all_page])
    @following_tweets = Tweet.following_tweets(current_user).page(params[:following_page])
    @tweet = current_user.tweets.new
  end
end
