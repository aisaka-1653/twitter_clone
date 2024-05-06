# frozen_string_literal: true

class DropLikesRetweetsBookmarksTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :likes do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    drop_table :retweets do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    drop_table :bookmarks do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
