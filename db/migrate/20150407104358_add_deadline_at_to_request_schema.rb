class AddDeadlineAtToRequestSchema < ActiveRecord::Migration
  def change
    add_column :request_schemata, :deadline_at, :datetime, default: nil
  end
end
