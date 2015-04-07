# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'Api test for division_controller: ' do
    before do
      @account = Account.first
      login_param = {
        email: @account.email,
        password: 'password'
      }
      post '/api/v1/login', login_param

      @division = Division.first
      @project = Project.first
      @request = @project.delegates.first.requests.first
      @request_schema = @division.request_schemata.first
      @schema_request = @request_schema.requests.first
    end

    # index
    it 'GET /api/v1/divisions/:id' do
      get "/api/v1/divisions/#{@division.id}"
      json = JSON.parse(response.body)
      eq_division = Division.find(@division.id)
      expect(json['id']).to eq(eq_division.id)
      expect(response.status).to eq(200)
    end


    # index
    it 'GET /api/v1/divisions/:id/projects' do
      get "/api/v1/divisions/:#{@division.id}/projects"
      expect(response.status).to eq(200)
    end
    
    # show
    it 'GET /api/v1/divisions/:id/projects/:id' do
      get "/api/v1/divisions/:#{@division.id}/projects/#{@project.id}"
      expect(response.status).to eq(200)
    end


    # index
    it 'GET /api/v1/divisions/:id/projects/:id/requests' do
      get "/api/v1/divisions/#{@division.id}/projects/#{@project.id}/requests"
      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/divisions/:id/projects/:id/requests/:id' do
      get "/api/v1/divisions/#{@division.id}/projects/#{@project.id}/requests/#{@request.id}"
      expect(response.status).to eq(200)
    end
    

    # index
    it 'GET /api/v1/divisions/:id/request_schemata' do
      get "/api/v1/divisions/#{@division.id}/request_schemata"
      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/divisions/:id/request_schemata/:id' do
      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}"
      expect(response.status).to eq(200)
    end


    # index
    it 'GET /api/v1/divisions/:id/request_schemata/:id/requests' do
      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}/requests"
      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/divisions/:id/request_schemata/:id/requests/:id' do
      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}/requests/#{@schema_request.id}"
      expect(response.status).to eq(200)
    end

    
    # show
    it 'GET /api/v1/divisions/:id/request_histories' do
      get "/api/v1/divisions/#{@division.id}/project_histories"
      expect(response.status).to eq(200)
    end
  end
end
