# frozen_string_literal: true

FactoryBot.define do
  factory :headhunter do
    email { 'test@test.com' }
    password { '123456' }
  end
end
