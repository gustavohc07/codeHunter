# frozen_string_literal: true

class AddStatusToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :status, :integer, default: 1
  end
end
