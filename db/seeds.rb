User.create!(
  email: "admin@mail.com",
  name: "Ho Ad Ten Min",
  password: "123456",
  password_confirmation: "123456",
  gender: 0,
  birthday: Time.zone.now - 22.years,
  address: FFaker::Address.street_address,
  company: FFaker::CompanyIT.name,
  role: 0,
  avatar: Rails.root.join("app/assets/images/img_1.jpg").open,
  dating_information_attributes: {
    height: Random.rand(160..190),
    weight: Random.rand(50..100),
    dating_location: "Ha Noi",
    dating_distance: Random.rand(10..50),
    start_age: 18,
    end_age: 50,
    prefer_gender: 2,
    description: FFaker::Lorem.sentence
  },
  images_attributes: [
    {link: Rails.root.join("app/assets/images/img_1.jpg").open},
    {link: Rails.root.join("app/assets/images/img_2.jpg").open},
    {link: Rails.root.join("app/assets/images/img_3.jpg").open}
  ]
)

User.create!(
  email: "admin2@mail.com",
  name: "Ho Ad Ten Min: Ok2",
  password: "123456",
  password_confirmation: "123456",
  gender: :female,
  birthday: Time.zone.now - 24.years,
  address: FFaker::Address.street_address,
  company: FFaker::CompanyIT.name,
  role: 0,
  avatar: Rails.root.join("app/assets/images/profile_user.jpg").open,
  dating_information_attributes: {
    height: Random.rand(160..190),
    weight: Random.rand(50..100),
    dating_location: "Ha Noi",
    dating_distance: Random.rand(10..50),
    start_age: 18,
    end_age: 50,
    prefer_gender: 2,
    description: FFaker::Lorem.sentence
  },
  images_attributes: [
    {link: Rails.root.join("app/assets/images/img_3.jpg").open},
    {link: Rails.root.join("app/assets/images/img_5.jpg").open},
    {link: Rails.root.join("app/assets/images/img_7.jpg").open}
  ]
)

User.create!(
  email: "admin3@mail.com",
  name: "Ho Ad Ten Min: Ok3",
  password: "123456",
  password_confirmation: "123456",
  gender: :female,
  birthday: Time.zone.now - 19.years,
  address: FFaker::Address.street_address,
  company: FFaker::CompanyIT.name,
  role: 0,
  avatar: Rails.root.join("app/assets/images/img_3.jpg").open,
  dating_information_attributes: {
    height: Random.rand(160..190),
    weight: Random.rand(50..100),
    dating_location: "Ha Noi",
    dating_distance: Random.rand(10..50),
    start_age: 18,
    end_age: 50,
    prefer_gender: 2,
    description: FFaker::Lorem.sentence
  },
  images_attributes: [
    {link: Rails.root.join("app/assets/images/img_6.jpg").open},
    {link: Rails.root.join("app/assets/images/img_5.jpg").open},
    {link: Rails.root.join("app/assets/images/img_4.jpg").open}
  ]
)

40.times do |n|
  location = ["Ha Noi, Viet Nam", "Ho Chi Minh", "Da Nang"].sample
  k = Random.rand(1..7)
  u = User.create!(
    email: "user#{n + 1}@mail.com",
    name: FFaker::Name.unique.name,
    password: "123456",
    password_confirmation: "123456",
    gender: Random.rand(0..1),
    birthday: Time.zone.now - Random.rand(19..60).years,
    address: FFaker::Address.street_address,
    company: FFaker::CompanyIT.name,
    role: 0,
    avatar: Rails.root.join("app/assets/images/img_#{k}.jpg").open,
    dating_information_attributes: {
      height: Random.rand(160..190),
      weight: Random.rand(50..100),
      dating_location: location,
      dating_distance: Random.rand(10..50),
      start_age: Random.rand(18..25),
      end_age: Random.rand(35..70),
      prefer_gender: Random.rand(0..2),
      description: FFaker::Lorem.sentence
    },
    images_attributes: [
      {link: Rails.root.join("app/assets/images/img_7.jpg").open},
    ]
  )
end

(10..20).each do |n|
  Reaction.create!(
    active_user_id: 2,
    passive_user_id: n,
    status: :like
  )
end

(21..30).each do |n|
  Reaction.create!(
    active_user_id: 2,
    passive_user_id: n,
    status: :dislike
  )
end

(31..40).each do |n|
  Reaction.create!(
    active_user_id: 2,
    passive_user_id: n,
    status: :block
  )
end

(10..20).each do |n|
  Reaction.create!(
    active_user_id: n,
    passive_user_id: 2,
    status: :like
  )
end
