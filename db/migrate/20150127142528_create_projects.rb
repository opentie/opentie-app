class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.timestamps null: false
    end
  end
end
