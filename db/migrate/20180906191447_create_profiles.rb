class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :email
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.string :sex
      t.string :gender

      t.timestamps
    end
  end
end
