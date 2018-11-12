class CreatePlatelets < ActiveRecord::Migration[5.2]
  def change
    create_table :platelets do |t|
      t.decimal :erythrocyte
      t.decimal :hemoglobin
      t.decimal :hematocrit
      t.decimal :vcm
      t.decimal :hcm
      t.decimal :chcm
      t.decimal :rdw
      t.decimal :leukocytep
      t.decimal :neutrophilp
      t.decimal :eosinophilp
      t.decimal :basophilp
      t.decimal :lymphocytep
      t.decimal :monocytep
      t.integer :leukocyteul
      t.integer :neutrophilul
      t.integer :eosinophilul
      t.integer :basophilul
      t.integer :lymphocyteul
      t.integer :monocyteul
      t.integer :total
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
