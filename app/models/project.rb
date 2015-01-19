class Project
  include Mongoid::Document
  include Mongoid::Enum
  include Opentie::Core::Request
  include Opentie::Core::FormSchema

  belongs_to :persona, inverse_of: :projects
  has_one :request
end
