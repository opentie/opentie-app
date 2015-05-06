class GlobalSetting < ActiveRecord::Base
  include WithClassName

  def self.get(key)
    where(name: key).first
  end
end
