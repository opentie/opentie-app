class Request
  include Opentie::Core::Request
  include Opentie::Core::FormSchema

  belongs_to :project
end
