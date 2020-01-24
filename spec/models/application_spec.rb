require 'rails_helper'

describe Application do
  describe 'associations' do
    it { should belong_to(:job) }
    it { should belong_to(:candidate) }
    it { should have_many(:messages) }
    it { should have_one(:feedback) }
    it { should have_one(:proposal) }
  end
end
