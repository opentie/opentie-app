class Project < ActiveRecord::Base
  has_many :delegates, dependent: :destroy
  has_many :accounts, through: :delegates
  accepts_nested_attributes_for :accounts

  has_many :project_histories
  
  store_accessor :payload
  
  validates_length_of :delegates, minimum: 1

  after_save do
    if changes.include? :name
      ProjectHistory.create(project: self, field: :name, value: changes[:name].last)
                            
    end
    if changes.include? :payload
      diff(changes[:payload].last, changes[:payload].first).each { |key, value|
        ProjectHistory.create(project: self, field: key, value: value)
      }
    end
  end

  private
  def diff(h1, h2)
    h1 ||= {}
    h2 ||= {}
    h1.dup.delete_if { |k, v| h2[k] == v }.merge!(h2.dup.delete_if { |k, v| h1.has_key?(k) })
  end
end
