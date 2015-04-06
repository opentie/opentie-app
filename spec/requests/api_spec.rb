# coding: utf-8
require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/login/' do
    before do
      post '/api/v1/login/'
    end

    it 'return 400? Bad Request' do
      expect(response.status).to eq(400)
    end
  end
end
