class AddPriorityToDelegates < ActiveRecord::Migration
  def change
    add_column :delegates, :priority, :integer, null: false, default: 0
  end
end
