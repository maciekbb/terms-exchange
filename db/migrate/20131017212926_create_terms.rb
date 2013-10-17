class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.time :hour
      t.references :day, index: true
      t.references :subject, index: true

      t.timestamps
    end
  end
end
