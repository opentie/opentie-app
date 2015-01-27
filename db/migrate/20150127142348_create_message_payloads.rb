class CreateMessagePayloads < ActiveRecord::Migration
  def change
    create_table :message_payloads do |t|

      t.timestamps null: false
    end
  end
end
