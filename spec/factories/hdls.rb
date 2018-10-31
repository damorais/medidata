require 'date'

FactoryBot.define do
  factory :hdl do
    value { 134 }
    date { "2018-10-30".to_date  }
    profile { nil }
  end
end
