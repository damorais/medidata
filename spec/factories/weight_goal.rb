require 'date'

FactoryBot.define do
  factory :weight_goal do
    value { 60.99 }
    date { "2018-10-05".to_date }
    profile { nil }
  end
end
