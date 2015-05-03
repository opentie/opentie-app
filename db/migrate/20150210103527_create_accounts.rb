class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name,                   null: false, default: ""
      t.string :email,                  null: false, default: ""
      t.string :password_digest,        null: false, default: ""
      t.string :session_token
      t.json :payload

      t.timestamps null: false
    end
    
    #add_index :accounts, :email, unique: true
    #add_index :accounts, :session_token, unique: true
  end
end
