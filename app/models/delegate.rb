class Delegate < ActiveRecord::Base
  belongs_to :account
  belongs_to :project
end
