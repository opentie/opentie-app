class Request < ActiveRecord::Base
  belongs_to :request_schema
  belongs_to :delegate
end
