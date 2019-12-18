class Profile < ApplicationRecord
  belongs_to :candidate
  has_one_attached :image

  enum status: { incomplete: 0, complete: 1 }
end
