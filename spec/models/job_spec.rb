# frozen_string_literal: true

require 'rails_helper'

describe Job do
  describe 'associations' do
    it {
      should belong_to(:headhunter)
      should have_many(:applications)
      should have_many(:candidates).through(:applications)
    }
  end

  describe 'validations' do
    it {
      should validate_presence_of(:title)
      should validate_presence_of(:level)
      should validate_presence_of(:number_of_vacancies)
      should validate_presence_of(:salary)
      should validate_presence_of(:description)
      should validate_presence_of(:abilities)
      should validate_presence_of(:deadline)
      should validate_presence_of(:start_date)
      should validate_presence_of(:location)
      should validate_presence_of(:contract_type)
    }
  end
end
