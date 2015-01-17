require 'opentie-core'
class Project
  include Mongoid::Document
  include OpentieCore::Project
end
