class CreateWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :weights do |t|
      t.decimal :value
      t.date :date
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
