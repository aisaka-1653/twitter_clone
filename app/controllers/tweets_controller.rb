class TweetsController < ApplicationController
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      @all_tweets = Tweet.sorted.page(params[:all_page])
      @following_tweets = Tweet.feed_for(current_user).page(params[:following_page])
      render 'homes/index', status: :unprocessable_entity
    end
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
