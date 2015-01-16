class DeviseCreateGroups < ActiveRecord::Migration
  def change
    create_table(:groups, id: :uuid) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # Group Information
      t.string   :name, null: false
      t.boolean  :is_jitsui, default: false, null: false

      t.timestamps
    end

    add_index :groups, :email,                unique: true
    add_index :groups, :reset_password_token, unique: true
    add_column :groups, :persona_id, :uuid, null: false
    add_column :groups, :project_id, :uuid
    # add_index :groups, :confirmation_token,   unique: true
    # add_index :groups, :unlock_token,         unique: true
  end
end
