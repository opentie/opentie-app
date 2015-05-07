class Request < ActiveRecord::Base
  soft_deletable
  include WithClassName
  include Formalizr::Querier

  STATUS_ROLE = {
    -1 => :not_yet,
    0 => :requested,
    1 => :refused
  }

  belongs_to :request_schema
  belongs_to :delegate
  delegate :project, to: :delegate

  alias_method :orig_attributes, :attributes
  def attributes
    orig_attributes.merge({
      is_required: is_required
    })
  end

  def is_required
    request_schema.required?(project)
  end

  def requestable?
    request_schema.requestable?(project)
  end
end
