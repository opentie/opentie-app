class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name,                   null: false, default: ""
      t.string :email,                  null: false, default: ""
      t.string :password_digest,        null: false, default: ""
      t.string :session_token
      t.json :payload
      t.string :confirmation_token
      t.boolean :confirmed_email,                    default: false

      t.timestamps null: false
    end
    
  end
end
