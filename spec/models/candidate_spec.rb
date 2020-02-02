# frozen_string_literal: true

require 'rails_helper'

describe Candidate do
  describe 'associations' do
    it { should have_one(:profile) }
    it { should have_many(:applications) }
    it { should have_many(:jobs).through(:applications) }
    it { should have_many(:proposals).through(:applications) }
  end
end
