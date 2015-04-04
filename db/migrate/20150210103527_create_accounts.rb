class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name,                   null: false, default: ""
      t.string :email,                  null: false, default: ""
      t.string :password_digest,        null: false, default: ""
      t.string :session_token
      t.hstore :payload
      
      t.timestamps null: false

      t.index :email, unique: true
      t.index :session_token, unique: true
    end
  end
end
