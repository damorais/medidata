class CreateHealthInsurances < ActiveRecord::Migration[5.2]
  def change
    create_table :health_insurances do |t|
      t.string :name
      t.string :provider
      t.string :plan_name
      t.string :plan_number
      t.string :plan_type
      t.date :start_date
      t.date :expiration_date
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
