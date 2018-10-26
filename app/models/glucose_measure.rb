class GlucoseMeasure < ApplicationRecord
  belongs_to :profile

  validates :value, presence: { message: "The value of glucose measure is mandatory." },
                            numericality: {greater_than: 0}

end
