FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }
    email { FFaker::Internet.email }
    password_digest { "password" }
    birthday { Time.zone.now }
    address { FFaker::Address.street_address }
    gender { FFaker::Random.rand 1..2 }
    company { FFaker::Company.name }
    dating_information_id { FactoryBot.create(:dating_information).id }
  end
end
