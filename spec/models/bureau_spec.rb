# coding: utf-8
require 'rails_helper'

RSpec.describe Bureau, :type => :model do
  it { should belong_to(:persona).as_inverse_of(:bureaus) }
end
