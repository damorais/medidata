class Pressure < ApplicationRecord
  belongs_to :profile

  validates :sis, presence: { message: "O valor da pressão sistólica é obrigatório." },
                  numericality: { greater_than: 0 }
  validates :dia, presence: { message: "O valor da pressão diastólica é obrigatório." },
                  numericality: { greater_than: 0 }
  validates :data, presence: { message: "A data da medição é obrigatória." }
end
