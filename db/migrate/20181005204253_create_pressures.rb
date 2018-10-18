class CreatePressures < ActiveRecord::Migration[5.2]
  def change
    create_table :pressures do |t|
      t.integer :sis
      t.integer :dia
      t.datetime :data

      t.timestamps
    end
  end
end
