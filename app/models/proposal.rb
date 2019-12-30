class Proposal < ApplicationRecord
  belongs_to :application
  belongs_to :headhunter
  belongs_to :candidate

  enum status: {decline: 0, pending: 1, accept: 2}
end
