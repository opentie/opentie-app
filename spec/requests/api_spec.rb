# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/register' do
    before do
      get '/api/v1/register'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/register/call_back' do
    before do
      get '/api/v1/register/call_back'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/dash_board' do
    before do
      get '/api/v1/dash_board'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/projects' do
    before do
      get '/api/v1/projects'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/projects/:id' do
    before do
      test_id = Project.all.first[:_id].to_s
      get "/api/v1/projects/#{test_id}"
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe 'POST /api/v1/projects' do
    before do
      post '/api/v1/projects'
    end

    it 'return 200 OK?' do
      pending 'Can not create projects yet.'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/groups' do
    before do
      get '/api/v1/groups'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/groups/:id' do
    before do
      test_id = Group.all.first[:_id].to_s
      get "/api/v1/groups/#{test_id}"
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/groups' do
    before do
      post '/api/v1/groups'
    end

    it 'return 200 OK?' do
      pending '未実装'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/accounts' do
    before do
      get '/api/v1/accounts'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/accounts/:id' do
    before do
      test_id = "hoge"
      get "/api/v1/accounts/#{test_id}"
    end

    it 'return 200 OK?' do
      pending 'できない。だってDevise accountだもん'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/personas' do
    before do
      get '/api/v1/personas'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/personas/:id' do
    before do
      test_id = "hoge"
      get "/api/v1/accounts/#{test_id}"
    end

    it 'return 200 OK?' do
      pending 'できない。だってDevise accountだもん'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
end
