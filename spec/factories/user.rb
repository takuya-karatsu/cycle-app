FactoryBot.define do
  factory :user do
    nickname               {Faker::Name.name}
    email                  {Faker::Internet.email}
    password               {"1a#{Faker::Internet.password}"}
    password_confirmation  {password}
  end
end