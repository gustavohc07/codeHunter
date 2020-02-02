# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :name
      t.string :last_name
      t.string :social_name
      t.date :birthday
      t.text :about_yourself
      t.string :university
      t.string :graduation_course
      t.date :year_of_graduation
      t.string :company
      t.string :role
      t.date :start_date
      t.date :end_date
      t.text :experience_description

      t.timestamps
    end
  end
end
