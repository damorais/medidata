class CreatePressures < ActiveRecord::Migration[5.2]
  def change
    create_table :pressures do |t|
      t.string :sis
      t.string :dia
      t.datetime :data
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
