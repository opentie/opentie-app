class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions, id: :uuid do |t|
      t.string :name
      t.json :payload

      t.timestamps null: false
    end
  end
end
