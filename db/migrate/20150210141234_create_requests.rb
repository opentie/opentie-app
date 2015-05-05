class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests, id: :uuid do |t|
      t.uuid :request_schema_id
      t.uuid :delegate_id

      t.json :payload

      t.timestamps null: false
    end

    add_index :requests, :delegate_id
    add_index :requests, :request_schema_id
  end
end
