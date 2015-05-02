class Request < ActiveRecord::Base
  soft_deletable
  include WithClassName

  belongs_to :request_schema
  belongs_to :delegate
end
