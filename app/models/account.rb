# -*- coding: utf-8 -*-
class Account < ActiveRecord::Base
  has_secure_password

  has_many :delegates, dependent: :destroy
  has_many :projects, through: :delegates
  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :delegates

  has_many :roles, dependent: :destroy
  has_many :divisions, through: :roles
  accepts_nested_attributes_for :divisions
  accepts_nested_attributes_for :roles

  validates :name, {
    presence: true,
    length: { in: 1..20 }
  }
  validates :email, {
    presence: true,
    uniqueness: true,
  }
  validates :password, {
    presence: true,
    length: { minimum: 8 }
  }
  validates :password_confirmation, {
    presence: true,
    length: { minimum: 8 }
  }

  def ensure_session_token!
    self.update_attribute(:session_token, generate_session_token)
  end
 
  private
  
  def generate_session_token
    loop do
      token = Devise.friendly_token
      return token unless Account.where(session_token: token).first
    end
  end
end
