require 'date'

FactoryBot.define do
  factory :non_hdl do
    value { 149 }
    date { "2018-10-30".to_date }
    profile { nil }
  end
end
