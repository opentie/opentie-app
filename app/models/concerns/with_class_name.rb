module WithClassName
  extend ActiveSupport::Concern

  def as_json(options={})
    hash = super options
    hash.merge!({_type: self.class.name.underscore})
    hash
  end
end
