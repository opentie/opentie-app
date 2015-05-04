class AddSoftDestroyedAtRequest < ActiveRecord::Migration
  def change
    add_column :requests, :soft_destroyed_at, :datetime
    add_index :requests, :soft_destroyed_at
  end
end
