# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :authorize_user!, only: %i[edit update]
  def show
    @tweets = @user.tweets.sorted.page(params[:tweets_page])
    @likes = Tweet.preload_user_and_avatar(@user.liked_tweets).page(params[:likes_page])
    @retweets = Tweet.preload_user_and_avatar(@user.retweeted_tweets).page(params[:retweets_page])
    @comments = @user.comments.sorted.page(params[:comments_page])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'プロフィールを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:header, :avatar, :display_name, :bio, :location, :website, :date_of_birth)
  end

  def authorize_user!
    return if current_user?(@user)

    redirect_to user_url(@user), alert: 'アクセス権限がありません'
  end
end
