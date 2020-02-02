# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :level
      t.integer :number_of_vacancies
      t.integer :salary
      t.text :description
      t.text :abilities
      t.date :deadline
      t.date :start_date
      t.string :location
      t.string :contract_type

      t.timestamps
    end
  end
end
