class Pressure < ApplicationRecord
  belongs_to :profile

  validates :systolic, presence: { message: "The value of systolic pressure is mandatory." },
                            numericality: {greater_than: 0}
  validates :diastolic, presence: { message: "The value of diastolic pressure is mandatory." },
                            numericality: {greater_than: 0}
  validates :date, presence: { message: "The date of measurement is mandatory." }

end
