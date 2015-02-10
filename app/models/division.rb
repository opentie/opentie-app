class Division < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :accounts, through: :roles
  accepts_nested_attributes_for :accounts
end
