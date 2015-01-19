# coding: utf-8
require 'rails_helper'

RSpec.describe Persona, :type => :model do

  it { should have_many(:accounts).as_inverse_of(:persona) }
  it { should have_many(:projects).as_inverse_of(:persona) }
  it { should have_many(:bureaus).as_inverse_of(:persona) }
  
end
