# coding: utf-8
require 'rails_helper'

RSpec.describe Account, :type => :model do

  it { should belong_to(:persona).as_inverse_of(:accounts) }

  it 'can be save.' do
    pending 'column 足りず'
    account = FactoryGirl.build(:account_factory)
    expect(account.save).to eq true
  end
end
