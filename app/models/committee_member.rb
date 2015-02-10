class CommitteeMember < ActiveRecord::Base
  belongs_to :account
  belongs_to :breau
end
