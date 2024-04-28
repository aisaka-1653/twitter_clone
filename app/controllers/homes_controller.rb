# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @all_tweets = Tweet.order(created_at: :desc).page(params[:all_page])
    @following_tweets = Tweet.where(user_id: current_user.following_user_ids).order(created_at: :desc).page(params[:following_page])
  end
end
