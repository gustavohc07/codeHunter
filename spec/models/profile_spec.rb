# frozen_string_literal: true

require 'rails_helper'

describe Profile do
  describe 'associations' do
    it {
      should belong_to(:candidate)
    }
  end
end
