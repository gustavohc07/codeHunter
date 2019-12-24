class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_many :messages
end
