require 'rails_helper'

RSpec.describe API do
  describe 'GET /api/v1/page' do
    before do
      get '/api/v1/page?hoge=30&fuga=60'
    end

    it 'return 200 OK?' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end  
end
