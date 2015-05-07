class AddOpenedAtToRequestSchemata < ActiveRecord::Migration
  def change
    add_column :request_schemata, :opened_at, :datetime, default: nil
  end
end
