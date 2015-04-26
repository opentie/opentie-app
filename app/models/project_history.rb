class ProjectHistory < ActiveRecord::Base
  include WithClassName

  belongs_to :project
end
