# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/projects' do
    before do
      @account = Account.first
      login_param = {
        email: @account.email,
        password: 'password'
      }
      post '/api/v1/login/', login_param

      @project = Project.first
    end

    it '/:id/' do
      puts Project.all.size
      get "/api/v1/projects/#{@project.id}/"
      puts JSON.parse(response.body)['id']
      expect(response.status).to eq(200)
    end
    
    it '/:id/requests/' do
      get "/api/v1/projects/#{@project.id}/requests/"
      expect(response.status).to eq(200)
    end
  end
end
