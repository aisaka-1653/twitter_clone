class DropLikesRetweetsBookmarksTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :likes
    drop_table :retweets
    drop_table :bookmarks
  end
end
