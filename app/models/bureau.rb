class Bureau
  include Mongoid::Document
  include Opentie::Core::Bureau

  belongs_to :persona, inverse_of: :bureaus
end
