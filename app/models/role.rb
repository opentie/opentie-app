class Role < ActiveRecord::Base
  include WithClassName

  belongs_to :account
  belongs_to :division

  has_many :projects, throuth: :project_comments
end
