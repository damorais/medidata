class CreateMedicalAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_appointments do |t|
      t.string :specialty
      t.text :address
      t.datetime :date
      t.string :professional
      t.string :type_appointment
      t.text :note
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
