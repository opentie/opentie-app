# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/login/' do
    before do
      get '/api/v1/login/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/login/call_back/' do
    before do
      get '/api/v1/login/call_back/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/request_types/' do
    before do
      get '/api/v1/request_types/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/request_types/sample_request.json' do
    before do
      get '/api/v1/request_types/sample_request.json'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/request_types/sample_request.form.json' do
    before do
      get '/api/v1/request_types/sample_request.form.json'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/request_types/sample_request/:id.json' do
    before do
      #FactoryGirl.create(:sample_request_factory)
      #test_id = SampleRequest.all.first[:_id].to_s
      #get "/api/v1/request_types/sample_request/#{test_id}.json"
    end

    it 'return 200 OK?' do
      pending "core bug"
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe 'GET /api/v1/dash_board/' do
    before do
      get '/api/v1/dash_board/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/projects/' do
    before do
      get '/api/v1/projects/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/projects/:id.json' do
    before do
      FactoryGirl.create(:project_factory)
      test_id = Project.all.first[:_id].to_s
      get "/api/v1/projects/#{test_id}.json"
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe 'POST /api/v1/projects/' do
    before do
      post '/api/v1/projects/', name: 'name'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/bureaus/' do
    before do
      get '/api/v1/bureaus/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/bureaus/:id.json' do
    before do
      FactoryGirl.create(:bureau_factory)
      test_id = Bureau.all.first[:_id].to_s
      get "/api/v1/bureaus/#{test_id}.json"
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/bureaus/' do
    before do
      post '/api/v1/bureaus/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/accounts/' do
    before do
      get '/api/v1/accounts/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/accounts/:id.json' do
    before do
      test_id = "hoge"
      get "/api/v1/accounts/#{test_id}.json"
    end

    it 'return 200 OK?' do
      pending 'Devise のcolumn作るのやだ'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/personas/' do
    before do
      get '/api/v1/personas/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/personas/:id.json' do
    before do
      test_id = "hoge"
      get "/api/v1/accounts/#{test_id}.json"
    end

    it 'return 200 OK?' do
      pending 'Devise のcolumn作るのやだ'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
end
