require 'rails_helper'

describe Proposal do
  describe 'associations' do
    it {
      should belong_to(:application)
      should belong_to(:headhunter)
      should belong_to(:candidate)
    }
  end
end
