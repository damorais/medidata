require 'date'

FactoryBot.define do
  factory :health_insurance do
    name { "Some health insurance" }
    provider { "Some health provider" }
    plan_name { "Some plan" }
    plan_number { "1234-5678" }
    plan_type { "Medical" }
    start_date { "2018-11-10".to_date }
    expiration_date { nil }
    profile { nil }
  end
end
