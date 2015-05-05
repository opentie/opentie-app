# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'Api test for dashboard_controller: ' do

    before do
      @account = Account.first
      login_params = {
        email: @account.email,
        password: 'password'
      }
      post '/api/v1/login', login_params
    end

    it 'GET /api/v1/dashboard' do
      get "/api/v1/dashboard"

      json = JSON.parse(response.body)

      expect(json).not_to eq(nil)

      expect(json['my_projects'].size).to eq(@account.projects.count)
      expect(json['my_divisions'].size).to eq(@account.divisions.count)
      expect(response.status).to eq(200)
    end
  end
end
