# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :application

  validates :feedback_message, presence: true
end
