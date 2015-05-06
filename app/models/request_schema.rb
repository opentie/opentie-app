class RequestSchema < ActiveRecord::Base
  include WithClassName

  has_many :requests
  belongs_to :division

  def self.requestable(project)
    all.each.select do |schema|
      project.query(
        schema.requestable_query
      )
    end
  end

  def requestable(project)
    if project.query(self.requestable_query)
      self
    else
      nil
    end
  end
end
