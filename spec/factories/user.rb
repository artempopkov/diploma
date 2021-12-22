FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
    name { Faker::Name.name }
  end
end
