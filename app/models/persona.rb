class Persona
  include Mongoid::Document
  include Opentie::Core::Persona
  
  has_many :accounts, inverse_of: :persona
  has_many :projects, inverse_of: :persona
  has_many :bureaus, inverse_of: :persona
end
