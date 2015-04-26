class GlobalSetting < ActiveRecord::Base
  DEFAULTS = {
    'project_schema.delegates_count_min': 0,
    'project_schema.delegates_count_max': 500
  }

  def self.get(key)
    where(id: key).first || DEFAULTS[key.to_sym]
  end
end
