# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'Api spec for register controller: ' do

    it 'GET /api/v1/register' do
      get "/api/v1/register"

      json = JSON.parse(response.body)

      expect(json['account_schema']).not_to eq(nil)
      expect(response.status).to eq(200)
    end

    it "POST /api/v1/regiser/" do
      params = {
        payload: {
          name: "よみがな",
          name_kana: "よみがな",
          email: "test@example.com",
          password: "password",
          password_confirmation: "password",
          name_kana: "ひらがな",
          college: "人文学類",
          grade: "D2",
          phone: "00-00000-000"
        }
      }

      expect {
        post "/api/v1/register/", params
      }.to change(Account, :count).by(1), change { ActionMailer::Base.deliveries.count }.by(1)

      expect(response.status).to eq(201)
    end

  end
end
