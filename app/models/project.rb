class Project < ActiveRecord::Base
  has_many :delegates, dependent: :destroy
  has_many :accounts, through: :delegates
  accepts_nested_attributes_for :accounts
  
  store_accessor :payload

  before_save do
    histories = []
    if changes.include? :name
      histories << {
        project: self,
        field: 'name',
        value: changes[:name].last
      }
    end
    if changes.include? :payload
      # TODO: diff
      p diff(changes[:payload].first, changes[:payload].last)
    end
  end

  private
  def diff(h1, h2)
    h1.dup.delete_if { |k, v| h2[k] == v }.merge!(h2.dup.delete_if { |k, v| h1.has_key?(k) })
  end
end
