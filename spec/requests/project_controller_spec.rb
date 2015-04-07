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
      @delegate = @project.delegates.first
      @request = @delegate.requests.first
      @request_schema = @request.request_schema
    end

    it '/:id/' do
      get "/api/v1/projects/#{@project.id}/"
      expect(response.status).to eq(200)
    end
    
    it '/:id/requests/' do
      get "/api/v1/projects/#{@project.id}/requests/"
      expect(response.status).to eq(200)
    end

    it '/:id/requests/:id' do
      get "/api/v1/projects/#{@project.id}/requests/#{@request.id}/"
      expect(response.status).to eq(200)
    end

    it '/:id/requests/:id/request_schemata/' do
      get "/api/v1/projects/#{@project.id}/request_schemata/"
      expect(response.status).to eq(200)
    end

    it '/:id/requests/:id/request_schemata/:id' do
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}"
    end
  end
end
