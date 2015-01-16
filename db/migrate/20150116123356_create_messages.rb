class CreateMessages < ActiveRecord::Migration
  def change
    create_table(:messages, id: :uuid) do |t|
      t.timestamps null: false
    end
    
    add_column :messages, :to, :uuid, null: false # persona id
    add_column :messages, :from, :uuid, null: false # persona id
    add_column :messages, :in_reply_to, :uuid, null: false # message id
  end
end
