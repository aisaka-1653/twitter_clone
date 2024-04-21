# frozen_string_literal: true

class AddUniqueIndexToUsersUidAndProvider < ActiveRecord::Migration[7.0]
  def up
    change_table :users do |t|
      t.change_null :uid, false
      t.index %i[uid provider], unique: true
    end
  end

  def down
    change_table :users do |t|
      t.change_null :uid, true
      t.remove_index %i[uid provider]
    end
  end
end
