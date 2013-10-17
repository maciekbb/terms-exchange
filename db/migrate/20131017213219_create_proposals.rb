class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.references :term, index: true
      t.references :user, index: true
      t.boolean :preferred

      t.timestamps
    end
  end
end
