class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.hstore :payload

      t.timestamps null: false
    end
  end
end