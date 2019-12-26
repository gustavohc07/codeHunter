class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_many :messages

  enum status: {in_progress: 0, rejected: 1, highlighted: 2, closed: 3}
end
