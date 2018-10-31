require 'date'

FactoryBot.define do
  factory :total do
    value { 187 }
    date { "2018-10-31".to_date }
    profile { nil }
  end
end
