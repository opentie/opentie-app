class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.uuid :account_id, default: ""
      t.uuid :project_id
      t.string :invited_email
      t.timestamps null: false
    end
  end
end
