class Delegate < ActiveRecord::Base
  belongs_to :account
  belongs_to :project

  validates_uniqueness_of :project_id, scope: [:priority]
end
