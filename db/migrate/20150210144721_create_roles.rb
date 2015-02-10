class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, id: :uuid do |t|
      t.uuid :division_id
      t.uuid :account_id

      t.timestamps null: false
    end

    add_index :roles, [:division_id, :account_id], unique: true
  end
end
