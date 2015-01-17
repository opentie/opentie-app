# -*- coding: utf-8 -*-
require 'rails_helper'

RSpec.describe OpentieCore::Request do
  describe "TestRequest" do
    class TestRequest < OpentieCore::Request
      subject "test request"
      application_period (Time.local 2015, 4, 1, 10)..(Time.local 2015, 5, 1, 10)
      declinable false
      in_charge_of :soumu

      field :fake_number, type: Integer
      field :fake_text, type: String
      field :fake_array, type: Array
    end
    subject(:tr) { TestRequest.new }

    it 'keishou' do
      expect(tr).to be_an_instance_of TestRequest
    end
  end
end
