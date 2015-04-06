# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/projects' do
    before do
      @account = FactoryGirl.create(:account)
      login_param = {
        email: @account.email,
        password: 'password'
      }
      post '/api/v1/login/', login_param

      @project = FactoryGirl.create(:project)
    end

    it '/:id/' do
      get "/api/v1/projects/#{@project.id}"
      expect(response.status).to eq(200)
    end
  end
end
