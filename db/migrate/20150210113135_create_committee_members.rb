class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_member, id: :uuid do |t|
      t.uuid :breau_id
      t.uuid :account_id

      t.timestamps null: false
    end

    add_index :committee_member, [:breau_id, :account_id], unique: true
  end
end
