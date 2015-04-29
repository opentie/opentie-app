class Proc
  def merge_hash(hash)
    proc {|endpoint_instance| self.call(endpoint_instance).merge(hash)}
  end
end
