class BookmarksController < InteractionsController
  def index
    @tweets = Tweet.preload_user_and_avatar(current_user.bookmarked_tweets).page(params[:page])
  end
end
