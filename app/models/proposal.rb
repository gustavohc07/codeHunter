class Proposal < ApplicationRecord
  belongs_to :application

  enum status: {decline: 0, pending: 1, accept: 2}
end
