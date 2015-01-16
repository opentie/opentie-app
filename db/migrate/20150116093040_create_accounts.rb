class CreateAccounts < ActiveRecord::Migration
  def change
    create_table(:accounts, id: :uuid) do |t|
      t.timestamps null: false

      t.string   :code, null: false
      t.string   :name, null: false
    end

    add_column :accounts, :persona_id, :uuid, null: false
  end
end
