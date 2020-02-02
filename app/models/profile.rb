# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :candidate
  has_one_attached :image

  def full_name
    "#{name} #{last_name}"
  end
end
