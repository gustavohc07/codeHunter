require 'rails_helper'

describe Feedback do
  describe 'associations' do
    it { should belong_to(:application) }
  end

  describe 'validations' do
    it { should validate_presence_of(:feedback_message) }
  end
end
