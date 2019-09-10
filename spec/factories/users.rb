FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }
    email { FFaker::Internet.email }
    password {"123456"}
    birthday { Time.zone.now }
    address { FFaker::Address.street_address }
    gender { FFaker::Random.rand 1..2 }
    company { FFaker::Company.name }
  end
end
