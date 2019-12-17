class Job < ApplicationRecord
  validates :title, :level, :number_of_vacancies,
            :salary, :description, :abilities,
            :deadline, :start_date, :location,
            :contract_type, presence: true
end
