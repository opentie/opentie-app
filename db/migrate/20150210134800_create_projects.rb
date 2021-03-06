class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.json :payload
      t.integer :number

      t.timestamps null: false
    end
    execute "CREATE SEQUENCE projects_number_seq INCREMENT BY 1 START WITH 20"
  end

  def self.down
    drop_table :projects
  end
end
