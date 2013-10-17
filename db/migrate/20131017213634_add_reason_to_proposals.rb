class AddReasonToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :reason, :text
  end
end
