class AddDependenciesToRequestSchema < ActiveRecord::Migration
  def change
    add_column :request_schemata, :requestable, :json, null: true
    add_column :request_schemata, :required, :json, null: true
  end
end
