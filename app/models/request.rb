class Request < ActiveRecord::Base
  soft_deletable
  include WithClassName

  STATUS_ROLE = {
    0 => :requested,
    1 => :refused
  }

  belongs_to :request_schema
  belongs_to :delegate
end
