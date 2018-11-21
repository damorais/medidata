# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  has_many :weights
  has_many :heights
  has_many :medications
  has_many :pressures
  has_many :contacts
  has_many :allergies
  has_many :hdls
  has_many :non_hdls
  has_many :ldls
  has_many :vldls
  has_many :totals
  has_many :reactions
  has_many :glucose_measures
  has_many :health_insurances
  has_many :medical_appointments

  validates :email, uniqueness: { case_sensitive: false,
                                  message: 'Já existe um perfil com este e-mail' },
                    presence: { message: 'O e-mail é obrigatório' }

  validates :firstname, presence: { message: 'O nome é obrigatório' }
  validates :lastname, presence: { message: 'O sobrenome é obrigatório' }
  validates :birthdate, presence: { message: 'A data de nascimento é obrigatória' }

  def latest_weight
    weights.order(:date).reverse_order.take
  end

  def latest_height
    heights.order(:date).reverse_order.take
  end

  def latest_glucose_measure
    glucose_measures.order(:date).reverse_order.take
  end

  def bmi
    if latest_height && latest_weight
      BodyMassIndex.calculate(latest_weight.value, latest_height.value)
    end
  end
end
