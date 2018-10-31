require 'date'

FactoryBot.define do
  factory :ldl do
    value { 120 }
    date { "2018-10-30".to_date }
    profile { nil }
  end
end
