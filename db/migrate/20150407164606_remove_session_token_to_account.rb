class RemoveSessionTokenToAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :session_token
  end
end
