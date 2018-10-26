class CreatePressures < ActiveRecord::Migration[5.2]
  def change
    create_table :pressures do |t|
      t.integer :systolic
      t.integer :diastolic
      t.datetime :date
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
