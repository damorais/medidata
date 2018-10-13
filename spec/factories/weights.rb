require 'date'

FactoryBot.define do
  factory :weight do
    value { 60.99 }
    date { "2018-10-05".to_date }
    profile { nil }
  end
end
