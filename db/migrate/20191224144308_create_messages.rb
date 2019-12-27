class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :application, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
