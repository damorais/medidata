require 'date'

FactoryBot.define do
  factory :vldl do
    value { 80 }
    date { "2018-10-31".to_date }
    profile { nil }
  end
end
