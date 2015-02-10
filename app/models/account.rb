class Account < ActiveRecord::Base
  has_many :delegates, dependent: :destroy
  has_many :projects, through: :delegates
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :delegates

  has_many :roles, dependent: :destroy
  has_many :divisions, through: :roles
  accepts_nested_attributes_for :divisions
  accepts_nested_attributes_for :roles
end
