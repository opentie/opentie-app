class CreateProjectHistories < ActiveRecord::Migration
  def change
    create_table :project_histories, id: :uuid do |t|
      t.uuid   :project_id
      t.string :field
      t.text   :value

      t.timestamps null: false
    end

    add_index :project_histories, :created_at
  end
end
