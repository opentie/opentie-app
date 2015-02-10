class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members, id: :uuid do |t|
      t.uuid :bureau_id
      t.uuid :account_id

      t.timestamps null: false
    end

    add_index :committee_members, [:bureau_id, :account_id], unique: true
  end
end
