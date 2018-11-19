class MedicalAppointment < ApplicationRecord
  belongs_to :profile

  validates :specialty, presence: { message: 'The value must be provided' }
  validates :address, presence: { message: 'The value must be provided' }
  validates :professional, presence: { message: 'The value must be provided' }

end
