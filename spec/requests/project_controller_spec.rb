# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'Api test for project_controller: ' do
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

    # show
    it 'GET /api/v1/projects/:id/' do
      get "/api/v1/projects/#{@project.id}/"
      json = JSON.parse(response.body)
      eq_project = Project.find(@project.id)
      expect(json['id']).to eq(eq_project.id)
      expect(response.status).to eq(200)
    end

    # new
    it 'GET /api/v1/projects/new/' do
      pending "なんでだあああああああああああああ"
      get "/api/v1/projects/new"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end
    
    # create
    it 'POST /api/v1/projects/' do
      post "/api/v1/projects/"
      #json = JSON.parse(response.body)
      expect(response.status).to eq(201)
    end

    # edit
    it 'GET /api/v1/projects/:id/edit' do
      get "/api/v1/projects/#{@project.id}/edit"
      expect(response.status).to eq(200)
    end

    # update
    it 'PUT /api/v1/projects/:id/' do
      put "/api/v1/projects/#{@project.id}/"
      expect(response.status).to eq(200)
    end
    

    # index
    it 'GET /api/v1/projects/:id/requests/:id/request_schemata/' do
      get "/api/v1/projects/#{@project.id}/request_schemata/"
      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/projects/:id/requests/:id/request_schemata/:id' do
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}"
      expect(response.status).to eq(200)
    end

    # new
    it 'GET /api/v1/projects/:id/request_schemata/:id/request/new/' do
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request/new"
      expect(response.status).to eq(200)
    end
    
    # create
    it 'POST /api/v1/projects/:id/request_schemata/:id/request/' do
      post "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request/"
      expect(response.status).to eq(201)
    end

    # edit
    it 'GET /api/v1/projects/:id/request_schemata/:id/request/edit' do
      get "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request/edit"
      expect(response.status).to eq(200)
    end

    # update
    it 'PUT /api/v1/projects/:id/request_schemata/:id/request/' do
      put "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request/"
      expect(response.status).to eq(200)
    end
    
    # delete
    it 'DELETE /api/v1/projects/:id/request_schemata/:id/request/' do
      delete "/api/v1/projects/#{@project.id}/request_schemata/#{@request_schema.id}/request/"
      expect(response.status).to eq(200)
    end
    
  end
end
