class CreateDiseases < ActiveRecord::Migration[5.2]
  def change
    create_table :diseases do |t|
      t.string :name
      t.text :description
      t.date :start
      t.date :finish
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
