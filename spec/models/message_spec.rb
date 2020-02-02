# frozen_string_literal: true

require 'rails_helper'

describe Message do
  describe 'associations' do
    it {
      should belong_to(:application)
    }
  end
end
