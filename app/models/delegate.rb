class Delegate < ActiveRecord::Base
  belongs_to :account
  belongs_to :project
  has_many :requests

  validates_uniqueness_of :project_id, scope: [:priority]
end
