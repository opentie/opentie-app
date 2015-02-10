class CreateRequestSchemata < ActiveRecord::Migration
  def change
    create_table :request_schemata, id: :uuid do |t|
      t.uuid :division_id

      t.json :payload
      
      t.timestamps null: false
    end
    add_index :request_schemata, :division_id
  end
end
