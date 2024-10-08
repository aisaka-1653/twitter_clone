# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :tweet, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content, null: false
      t.string :username, null: false

      t.timestamps
    end
  end
end
