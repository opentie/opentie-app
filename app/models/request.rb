class Request < ActiveRecord::Base
  include WithClassName

  belongs_to :request_schema
  belongs_to :delegate
end
