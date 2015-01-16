class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.timestamps null: false
    end

    add_column :personas, :group_id, :uuid, null: false
    add_column :personas, :account_id, :uuid, null: false
  end
end
