class CreateMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :categorize
      t.date :start
      t.date :finish
      t.string :dosage
      t.string :infadd
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
