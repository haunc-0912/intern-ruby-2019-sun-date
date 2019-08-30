FactoryBot.define do
  factory :image do
    alt { FFaker::Name.unique.name }
    link { FFaker::Image.url }
    association :user
  end
end
