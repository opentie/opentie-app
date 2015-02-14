class AddDeviseToAccounts < ActiveRecord::Migration
  def self.up
    change_table(:accounts) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Authenticate
      t.string :authentication_token

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :accounts, :email,                unique: true
    add_index :accounts, :reset_password_token, unique: true
  end

  def self.down
    remove_column :accounts, :email
    remove_column :accounts, :encrypted_password
    remove_column :accounts, :reset_password_token
    remove_column :accounts, :reset_password_sent_at
    remove_column :accounts, :remember_created_at
    remove_column :accounts, :authentication_token
  end
end
