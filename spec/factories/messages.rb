FactoryBot.define do
  factory :message do
    sender_id { FactoryBot.create(:user).id }
    receiver_id { FactoryBot.create(:user).id }
    content { FFaker::Lorem.paragraph }
  end
end
