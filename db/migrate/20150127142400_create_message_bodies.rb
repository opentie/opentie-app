class CreateMessageBodies < ActiveRecord::Migration
  def change
    create_table :message_bodies do |t|

      t.timestamps null: false
    end
  end
end
