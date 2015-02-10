class Account < ActiveRecord::Base
  has_many :delegates, dependent: :destroy
  has_many :projects, through: :delegates
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :delegates

  has_many :committee_members, dependent: :destroy
  has_many :bureaus, through: :committee_members
  accepts_nested_attributes_for :bureaus
  accepts_nested_attributes_for :committee_members
end
