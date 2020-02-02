# frozen_string_literal: true

require 'rails_helper'

describe Headhunter do
  describe 'associations' do
    it { should have_many(:jobs) }
    it { should have_many(:applications).through(:jobs) }
    it { should have_many(:candidates).through(:applications) }
    it { should have_many(:proposals) }
  end
end
