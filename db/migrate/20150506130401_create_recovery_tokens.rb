class CreateRecoveryTokens < ActiveRecord::Migration
  def change
    create_table :recovery_tokens, id: :uuid do |t|
      t.string :token,      null: false
      t.uuid   :account_id, null: false
      t.boolean :resetted_password, default: false

      t.timestamps null: false
    end

    add_index :recovery_tokens, [:token], unique: true
  end
end
