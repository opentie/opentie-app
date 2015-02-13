class CreateGlobalSettings < ActiveRecord::Migration
  def change
    create_table :global_settings, id: :uuid do |t|
      t.string :name
      t.json :value

      t.timestamps null: false
    end
  end
end
