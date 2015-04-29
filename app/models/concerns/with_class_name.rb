module WithClassName
  extend ActiveSupport::Concern

  def as_json(options={})
    super ({ methods: :_type }).merge(options || {})
  end

  def _type
    self.class.name.underscore
  end
end
