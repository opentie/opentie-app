class CreateProjectComments < ActiveRecord::Migration
  def change
    create_table :project_comments, id: :uuid do |t|
      t.uuid :project_id
      t.uuid :role_id
      t.text :comment

      t.timestamps null: false
    end
  end
end
