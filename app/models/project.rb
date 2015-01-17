require 'opentie-core'
class Project
  include Mongoid::Document
  include OpentieCore::Project

  belongs_to :group, inverse_of: :project
end
