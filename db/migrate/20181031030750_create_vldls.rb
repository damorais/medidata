class CreateVldls < ActiveRecord::Migration[5.2]
  def change
    create_table :vldls do |t|
      t.integer :value
      t.date :date
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
