class AddAcceptedIdToProposals < ActiveRecord::Migration
  def change
    add_reference :proposals, :accepted, index: true
  end
end
