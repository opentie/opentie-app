class CreateDelegates < ActiveRecord::Migration
  def change
    create_table :delegates, id: :uuid do |t|
      t.uuid :project_id
      t.uuid :account_id

      t.timestamps null: false
    end

    add_index :delegates, [:project_id, :account_id], unique: true
  end
end
