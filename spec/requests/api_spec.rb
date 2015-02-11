# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/login/' do
    before do
      get '/api/v1/login/'
    end

    it 'return 302 Redirect?' do
      expect(response.status).to eq(302)
    end
  end

  describe 'POST /api/v1/login/call_back/' do
    before do
      post '/api/v1/login/call_back/'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/requests/' do
    before do
      get '/api/v1/requests/'
    end

    it 'return 200 OK?' do
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
      test_id = "hoge"
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
end
