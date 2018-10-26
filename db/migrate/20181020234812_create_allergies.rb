class CreateAllergies < ActiveRecord::Migration[5.2]
  def change
    create_table :allergies do |t|
      t.string :name
      t.text :description
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
