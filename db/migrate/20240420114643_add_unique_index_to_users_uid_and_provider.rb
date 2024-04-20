class AddUniqueIndexToUsersUidAndProvider < ActiveRecord::Migration[7.0]
  def up
    change_table :users do |t|
      t.index %i[uid provider], unique:true
    end
  end
  
  def down
    change_table :users do |t|
      t.remove_index %i[uid provider]
    end
  end
end
