class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.sorted.page(params[:tweets_page])
  end

  def edit
  end
end
