class Bureau < ActiveRecord::Base
  has_many :committee_members, dependent: :destroy
  has_many :accounts, through: :committee_members
  accepts_nested_attributes_for :accounts
end
