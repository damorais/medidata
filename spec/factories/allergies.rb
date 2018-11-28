FactoryBot.define do
  factory :allergy do
    name { "Dipiridamol" }
    cause { "Remédio" }
    allergen { "Fenazona" }
    known_reaction { "Sim" }
    description { "Dipirona Sódica" }
    start { "2018-11-28".to_date }
    finish { "2018-11-28".to_date }
    profile { nil }
  end
end
