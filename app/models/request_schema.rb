class RequestSchema < ActiveRecord::Base
  include WithClassName

  has_many :requests
  belongs_to :division
end
