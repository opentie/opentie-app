# coding: utf-8
require 'rails_helper'

RSpec.describe Request, :type => :model do

  it { should belong_to(:project) }

  describe "TestProject" do
    pending "おなかすいた"
    class TestRequest < Request
      subject "test request"
      application_period (Time.local 2015, 1, 1, 10)..(Time.local 2015, 5, 1, 10)
      optional false
      in_charge_of :soumu

      field :fake_number, type: Integer
      field :fake_text, type: String
      field :fake_array, type: Array
    end
  end
end
