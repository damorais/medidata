FactoryBot.define do
  factory :disease do
    name { "Cardiaca" }
    description { "Arritmia" }
    start { "2018-11-27".to_date }
    finish { "2018-11-27".to_date }
    profile { nil }
  end
end
