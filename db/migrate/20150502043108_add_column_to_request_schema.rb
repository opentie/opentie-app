class AddColumnToRequestSchema < ActiveRecord::Migration
  def change
    add_column :request_schemata, :name, :string, null: false, default: ""
  end
end
