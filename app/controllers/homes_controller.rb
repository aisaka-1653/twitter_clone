# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @all_tweets = Tweet.sorted.page(params[:all_page])
    @following_tweets = Tweet.feed_for(current_user).page(params[:following_page])
    @tweet = current_user.tweets.new
  end
end
