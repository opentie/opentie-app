class Role < ActiveRecord::Base
  include WithClassName

  belongs_to :account
  belongs_to :division

  has_many :project_comments
  has_many :projects, through: :project_comments
end
