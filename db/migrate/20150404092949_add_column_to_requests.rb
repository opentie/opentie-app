class AddColumnToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :status, :integer, null: false, default: 0
  end
end
