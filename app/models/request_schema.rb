class RequestSchema < ActiveRecord::Base
  include WithClassName

  has_many :requests
  belongs_to :division

  scope :opening, -> {
    where('opened_at < ?', DateTime.now).where('deadline_at >= ?', DateTime.now)
  }

  def self.requestable(project)
    all.to_a.select{ |schema| schema.requestable?(project) }
  end

  def self.required(project)
    all.to_a.select{ |schema| schema.required?(project) }
  end

  def requestable?(project)
    return true if requestable.nil?
    project.query(requestable)
  end

  def required?(project)
    return false if required.nil?
    requestable?(project) && project.query(required)
  end
end
