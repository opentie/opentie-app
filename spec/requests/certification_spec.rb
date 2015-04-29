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