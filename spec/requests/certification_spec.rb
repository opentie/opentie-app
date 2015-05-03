# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'Api spec for certification controller: ' do

    before do
      @path = '/api/v1/login/'
      account = Account.first
      @login_params = {
        email: account.email,
        password: 'password'
      }
      @another_params = {
        email: "fake@example.com",
        password: "password"
      }
      @another_params2 = {
        email: account.email,
        password: "fakepass"
      }
    end
    
    it 'failed login test' do
      post @path, @another_params
      json = JSON.parse(response.body)
      expect(json['message']).to eq("email doesn't match")
      expect(response.status).to eq(401)
    end

    it 'failed login test2' do
      post @path, @another_params2
      json = JSON.parse(response.body)
      expect(json['message']).to eq("password doesn't match")
      expect(response.status).to eq(401)
    end

    it 'Login test' do
      post @path, @login_params
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Accept authenticate')
      expect(response.status).to eq(201)
    end
    
    it 'Relogin test' do
      post @path, @login_params
      post @path, @login_params
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Already authenticated')
      expect(response.status).to eq(201)
    end

    it 'Logout test' do
      post @path, @login_param
      post '/api/v1/logout/'
      json = JSON.parse(response.body)
      expect(json['message']).to eq('Successful logout')
      expect(response.status).to eq(201)
    end
  end
end
