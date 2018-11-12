FactoryBot.define do
  factory :reaction do
    name { "Propofol" }
    cause { "Medicamento" }
    description { "Aritmia Cardiaca" }
    start { "2018-11-12".to_date }
    finish { "2018-11-12".to_date }
    profile { nil }
  end
end
