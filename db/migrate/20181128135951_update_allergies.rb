class UpdateAllergies < ActiveRecord::Migration[5.2]
  def change
    change_table :allergies do |t|
      t.string :cause
      t.string :allergen
      t.string :known_reaction
      t.date :start
      t.date :finish
    end  
  end
end
