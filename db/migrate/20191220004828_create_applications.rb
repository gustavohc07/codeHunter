# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
