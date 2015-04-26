class Role < ActiveRecord::Base
  include WithClassName

  belongs_to :account
  belongs_to :division
end
