class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :delegates, dependent: :destroy
  has_many :projects, through: :delegates
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :delegates

  has_many :roles, dependent: :destroy
  has_many :divisions, through: :roles
  accepts_nested_attributes_for :divisions
  accepts_nested_attributes_for :roles

  def self.ensure_session_token
    loop do
      token = Devise.friendly_token
      break token unless Account.where(remember_token: token).first
    end
  end
end
