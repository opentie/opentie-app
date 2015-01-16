class CreateProjects < ActiveRecord::Migration
  def change
    create_table(:projects, id: :uuid) do |t|
      t.timestamps null: false

      t.text :name, null: false
    end

    add_column :projects, :group_id, :uuid, null: false
  end
end
