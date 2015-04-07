class Division < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :accounts, through: :roles
  has_many :request_schemata
  accepts_nested_attributes_for :accounts
end
