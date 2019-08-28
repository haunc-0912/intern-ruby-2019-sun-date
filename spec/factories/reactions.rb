FactoryBot.define do
  factory :reaction do
    active_user_id { FactoryBot.create(:user).id }
    passive_user_id { FactoryBot.create(:user).id }
  end
end
