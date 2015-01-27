class CreateBureaus < ActiveRecord::Migration
  def change
    create_table :bureaus do |t|

      t.timestamps null: false
    end
  end
end
