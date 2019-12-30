class AddFeedbackMessagesToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :acceptance_message, :text
    add_column :proposals, :reject_message, :text
  end
end
