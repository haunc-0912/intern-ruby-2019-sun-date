FactoryBot.define do
  factory :dating_information do
    height { FFaker::Random.rand 100..200 }
    weight { FFaker::Random.rand 40..100 }
    dating_location { FFaker::Address.street_address }
    dating_distance { FFaker::Random.rand 40..100 }
    start_age { FFaker::Random.rand 15..20 }
    end_age { FFaker::Random.rand 21..50 }
    description { FFaker::Lorem.paragraph }
  end
end
