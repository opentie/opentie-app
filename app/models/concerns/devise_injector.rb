#====================
# Lucky * Star
#====================
module DeviseInjector
  extend ActiveSupport::Concern
  module ClassMethods
    include Devise::Models
  end
end
