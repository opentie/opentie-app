class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.hstore :payload
      t.integer :number

      t.timestamps null: false
    end
  end
end
