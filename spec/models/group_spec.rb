# coding: utf-8
require 'rails_helper'

RSpec.describe Group, :type => :model do
  #pending '未だ踏まれず'

  it { should belong_to(:persona).as_inverse_of(:groups) }
  
  it 'can be save.' do
    group = FactoryGirl.build(:group_factory)
    expect(group.save).to eq true
  end
end
