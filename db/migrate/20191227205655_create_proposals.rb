class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.date :start_date
      t.integer :salary
      t.text :benefits
      t.text :bonus
      t.text :additional_info
      t.references :application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
