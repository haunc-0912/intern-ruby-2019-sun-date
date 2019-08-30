FactoryBot.define do
  factory :notification do
    owner_id { FactoryBot.create(:user).id }
    recipient_id { FactoryBot.create(:user).id }
    trackable_id { FactoryBot.create(:message).id }
    trackable_type { "message" }
    content { FFaker::Lorem.paragraph }
  end
end
