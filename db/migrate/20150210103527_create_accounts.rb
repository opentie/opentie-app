class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name,                   null: false, default: ""
      t.string :email,                  null: false, default: ""
      t.string :password_digest,        null: false, default: ""
      t.string :session_token
      t.hstore :payload
      
      t.timestamps null: false
    end
  end
end
