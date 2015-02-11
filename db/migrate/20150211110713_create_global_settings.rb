class CreateGlobalSettings < ActiveRecord::Migration
  def change
    create_table :global_settings, id: :string do |t|
      t.json :value

      t.timestamps null: false
    end
  end
end
