# frozen_string_literal: true

class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false

      t.timestamps
    end
  end
end
