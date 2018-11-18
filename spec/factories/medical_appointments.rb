FactoryBot.define do
  factory :medical_appointment do
    specialty { "MyString" }
    address { "MyText" }
    date { "2018-11-18 13:29:15" }
    professional { "MyString" }
    type_appointment { "MyString" }
    note { "MyText" }
    profile { nil }
  end
end
