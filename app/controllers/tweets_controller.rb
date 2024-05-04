class TweetsController < ApplicationController
  def create
    @tweet = current_user.tweets.build(tweet_params)
    unless @tweet.save
      flash[:danger] = @tweet.errors.full_messages[0]
    end
    redirect_to root_path
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
