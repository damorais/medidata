class CreateGlucoseMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :glucose_measures do |t|
      t.float :value
      t.datetime :date
      t.boolean :fasting
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
