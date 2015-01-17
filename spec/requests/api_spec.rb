require 'rails_helper'

RSpec.describe API do
  let(:article) { FactoryGirl.create(:article, user: user) }
  describe 'GET /api/v1/page' do
    let(:method) { 'get' }
    let(:url)    { '/api/v1/page' }

    it_behaves_like('200')
  end  
end
