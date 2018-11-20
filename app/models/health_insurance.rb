class HealthInsurance < ApplicationRecord
  belongs_to :profile

  validates :name, presence: { message: "The name must be provided" }
  validates :plan_type, presence: { message: "Your health insurance must have a type (like, i.e Medical)"}
  validates :provider, presence: { message: "You must inform the provider" }
  validates :plan_number, presence: { message: "You must inform the plan number" }
  validates :start_date, presence: { message: "A start date must be informed" }

end
