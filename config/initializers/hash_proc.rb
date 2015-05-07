class Hash
  def deep_except!(*keys)
    keys.each { |key| delete(key) }
    self.each { |k, v|
      v.except!(*keys) if v.is_a? Hash
    }
    self
  end

  def deep_except(*keys)
    dup.deep_except!(*keys)
  end
end
