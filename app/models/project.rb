class Project < ActiveRecord::Base
  has_many :delegates, dependent: :destroy
  has_many :accounts, through: :delegates
  accepts_nested_attributes_for :accounts
end
