require 'date'

FactoryBot.define do
  factory :height do
    value { 1.80 }
    date { "2018-10-05".to_date }
    profile { nil }
  end
end
