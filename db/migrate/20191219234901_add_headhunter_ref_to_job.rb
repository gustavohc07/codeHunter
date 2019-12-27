class AddHeadhunterRefToJob < ActiveRecord::Migration[6.0]
  def change
    add_reference :jobs, :headhunter, foreign_key: true
  end
end
