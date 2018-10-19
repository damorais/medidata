class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.string :mobile
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
