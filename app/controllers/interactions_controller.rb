class InteractionsController < ApplicationController
  before_action :set_tweet

  def create
    interaction = @tweet.interactions.build(user: current_user, type: params[:type])
    flash[:danger] = interaction.errors.full_messages[0] unless interaction.save
    redirect_to request.referer || root_path
  end

  def destroy
    @tweet.interactions.find(params[:id]).destroy!
    redirect_to request.referer || root_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
