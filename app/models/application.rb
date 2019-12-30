class Application < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_many :messages
  has_one :feedback
  has_one :proposal

  enum status: {in_progress: 0, rejected: 1, highlighted: 2, proposal_sent: 3, closed: 5}
end
