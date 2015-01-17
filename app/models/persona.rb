class Persona
  include Mongoid::Document

  has_many :accounts, inverse_of: :persona
  has_many :groups, inverse_of: :persona
end
