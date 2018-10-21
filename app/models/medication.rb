class Medication < ApplicationRecord
  belongs_to :profile
  validates :name, presence: { message: "O nome é obrigatório" }
  validates :categorize, presence: { message: "O tipo é obrigatório" }
  validates :start, presence: { message: "A data de inicio é obrigatória" }
  validates :finish, presence: { message: "A data de fim é obrigatória" }
  validates :dosage, presence: { message: "A dosagem é obrigatória" }
end
