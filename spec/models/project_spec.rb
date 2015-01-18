# coding: utf-8
require 'rails_helper'

RSpec.describe Project, :type => :model do
  # pending '未だ踏まれず'
  describe "TestProject" do
    class TestRequest < Opentie::Core::Request
      subject "test request"
      application_period (Time.local 2015, 1, 1, 10)..(Time.local 2015, 5, 1, 10)
      declinable false
      in_charge_of :soumu

      field :fake_number, type: Integer
      field :fake_text, type: String
      field :fake_array, type: Array
    end

    p1 = Project.new
    p p1.available_requests
  end
end
