class Project < ActiveRecord::Base
  include WithClassName
  include Formalizr::Querier

  has_many :invitations
  has_many :project_comments
  has_many :roles, through: :project_comments
  has_many :delegates, dependent: :destroy
  has_many :accounts, through: :delegates
  accepts_nested_attributes_for :accounts

  has_many :project_histories

  store_accessor :payload

  before_create :increment_number

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

  def self.initialize_number(val)
    Project.connection.execute "SELECT setval('projects_number_seq', #{val})"
  end

  def complete?
    min_length = GlobalSetting.get 'project_schema.delegates_count_min'
    max_length = GlobalSetting.get 'project_schema.delegates_count_max'
    value = self.delegates.count

    unless (min_length..max_length).cover? value
      logger.warn "Number of delegate is out of range: #{value}"
      false
    else
      true
    end
  end

  private
  def increment_number
    value = Project.connection.execute "SELECT nextval('projects_number_seq')"
    self.number = value[0]["nextval"]
  end

  def diff(h1, h2)
    h1 ||= {}
    h2 ||= {}
    h1.dup.delete_if { |k, v| h2[k] == v }.merge!(h2.dup.delete_if { |k, v| h1.has_key?(k) })
  end
end
