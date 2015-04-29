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
      # Use @request_, because @request used by rack 
      @request_ = @project.delegates.first.requests.first
      @request_schema = @division.request_schemata.first
      @schema_request = @request_schema.requests.first
    end

    # show
    it 'GET /api/v1/divisions/:id' do
      get "/api/v1/divisions/#{@division.id}"
      
      json = JSON.parse(response.body)['division']
      division = Division.where(id: json['id']).first

      expect(division).not_to eq(nil)
      expect(json['id']).to eq(@division.id)
      expect(json['accounts'].count).to eq(division.accounts.count)

      expect(response.status).to eq(200)

      get "/api/v1/divisions/hogehogehoge123123"
      expect(response.status).to eq(404)
    end


    # index
    it 'GET /api/v1/divisions/:id/projects' do
      get "/api/v1/divisions/#{@division.id}/projects"
      
      json = JSON.parse(response.body)

      json['projects'].each do |project|
        p = Project.find_by(id: project['id'])
        expect(p).not_to eq(nil)
      end
      
      expect(json['division']['id']).to eq(@division.id)

      expect(json['projects'].size).to eq(Project.all.size)
      expect(response.status).to eq(200)
    end
    
    # show
    it 'GET /api/v1/divisions/:id/projects/:id' do
      get "/api/v1/divisions/#{@division.id}/projects/#{@project.id}"
      
      json = JSON.parse(response.body)
      project = Project.where(id: json['project']['id']).first
      
      expect(json['division']['id']).to eq(@division.id)

      expect(project).not_to eq(nil)
      expect(json['project']['id']).to eq(@project.id)
      expect(response.status).to eq(200)

      get "/api/v1/divisions/:#{@division.id}/projects/hogehogehoge123123"
      expect(response.status).to eq(404)
    end


    # index
    it 'GET /api/v1/divisions/:id/projects/:id/requests' do
      get "/api/v1/divisions/#{@division.id}/projects/#{@project.id}/requests"
      
      json = JSON.parse(response.body)
      
      json['requests'].each do |request|
        expect(Request.find_by(id: request['id'])).not_to eq(nil)
        expect(Delegate.find_by(id: request['delegate_id']).project_id).to eq(@project.id) 
      end

      expect(json['project']['id']).to eq(@project.id)

      expect(json['division']['id']).to eq(@division.id)
      
      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/divisions/:id/projects/:id/requests/:id' do
      get "/api/v1/divisions/#{@division.id}/projects/#{@project.id}/requests/#{@request_.id}"
      
      json = JSON.parse(response.body)
      request = Request.find_by(id: json['request']['id'])

      expect(request).not_to eq(nil)
      expect(json['request']['id']).to eq(@request_.id)
      expect(response.status).to eq(200)

      expect(json['project']['id']).to eq(@project.id)

      expect(json['division']['id']).to eq(@division.id)

      get "/api/v1/divisions/#{@division.id}/projects/#{@project.id}/requests/hogehogehoge123123"
      expect(response.status).to eq(404)
    end

    
    # index
    it 'GET /api/v1/divisions/:id/request_schemata' do
      get "/api/v1/divisions/#{@division.id}/request_schemata"

      json = JSON.parse(response.body)
      
      json['request_schemata'].each do |schema|
        expect(RequestSchema.find_by(id: schema['id'])).not_to eq(nil)
        expect(RequestSchema.find_by(id: schema['id']).division_id).to eq(@division.id)
      end

      expect(json['division']['id']).to eq(@division.id)

      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/divisions/:id/request_schemata/:id' do
      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}"
      
      json = JSON.parse(response.body)
      schema = RequestSchema.find_by(id: json['request_schema']['id'])
      
      expect(schema).not_to eq(nil)
      expect(json['request_schema']['id']).to eq(@request_schema.id)
      expect(response.status).to eq(200)

      expect(json['division']['id']).to eq(@division.id)
      
      get "/api/v1/divisions/#{@division.id}/request_schemata/hogehogehoge123123"
      expect(response.status).to eq(404)
    end


    # index
    it 'GET /api/v1/divisions/:id/request_schemata/:id/requests' do
      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}/requests"
      json = JSON.parse(response.body)

      json['requests'].each do |request|
        expect(Request.find_by(id: request['id'])).not_to eq(nil)
        expect(Request.find_by(id: request['id']).request_schema_id).to eq(@request_schema.id)
      end

      expect(json['division']['id']).to eq(@division.id)

      expect(json['request_schema']['id']).to eq(@request_schema.id)

      expect(response.status).to eq(200)
    end

    # show
    it 'GET /api/v1/divisions/:id/request_schemata/:id/requests/:id' do
      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}/requests/#{@schema_request.id}"
      json = JSON.parse(response.body)
      request = Request.find_by(id: json['request']['id'])

      expect(request).not_to eq(nil)
      expect(json['request']['id']).to eq(@schema_request.id)
      expect(response.status).to eq(200)

      expect(json['division']['id']).to eq(@division.id)

      expect(json['request_schema']['id']).to eq(@request_schema.id)

      get "/api/v1/divisions/#{@division.id}/request_schemata/#{@request_schema.id}/requests/hogehogehoge123123"
      expect(response.status).to eq(404)
    end

    
    # show
    it 'GET /api/v1/divisions/:id/request_histories' do
      get "/api/v1/divisions/#{@division.id}/project_histories"
      
      json = JSON.parse(response.body)
      
      json['project_histories'].each do |history|
        expect(ProjectHistory.find_by(id: history['id'])).not_to eq(nil)
      end

      expect(json['division']['id']).to eq(@division.id)
      
      expect(response.status).to eq(200)
    end
  end
end
