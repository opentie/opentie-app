class ProjectComment < ActiveRecord::Base
  belongs_to :project
  belongs_to :division

end
