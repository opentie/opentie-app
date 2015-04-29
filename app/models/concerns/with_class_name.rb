module WithClassName
  extend ActiveSupport::Concern
  
  def attributes
    super.merge({'_type' => _type})
  end

  def _type
    self.class.name.underscore
  end
end
