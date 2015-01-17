class Group
  include Mongoid::Document

  belongs_to :persona, inverse_of: :groups
  has_one :project, inverse_of: :group

  field :name, type: String
  field :is_jitsui, type: Boolean
  field :role, type: String
end
