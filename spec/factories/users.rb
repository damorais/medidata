FactoryBot.define do
  factory :user do
    email { 'teste@example.org' }
    password { 'superdupersecret' } 
    password_confirmation { 'superdupersecret' }
  end
end
