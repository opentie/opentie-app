class RequestSchema < ActiveRecord::Base
  has_many :requests
  belongs_to :division
end
