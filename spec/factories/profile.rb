FactoryBot.define do
    factory :profile do
        email { "joao@example.org"}
        firstname { "João" }
        lastname  { "da Silva" }
        birthdate { "2000-12-15" }
        sex { "Male" }
        gender { "Male" }
    end
end