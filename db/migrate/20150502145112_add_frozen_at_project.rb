class AddFrozenAtProject < ActiveRecord::Migration
  def change
    add_column :projects, :frozen_at, :datetime

    add_index :projects, :frozen_at
  end
end


