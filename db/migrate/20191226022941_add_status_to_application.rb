# frozen_string_literal: true

class AddStatusToApplication < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :status, :integer, default: 0
  end
end
