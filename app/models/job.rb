class Job < ApplicationRecord
  validates :title, :level, :number_of_vacancies,
            :salary, :description, :abilities,
            :deadline, :start_date, :location,
            :contract_type, presence: true

  belongs_to :headhunter
  has_many :applications
  has_many :candidates, through: :applications
end
