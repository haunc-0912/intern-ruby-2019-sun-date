# User.create!(
#   email: "admin@mail.com",
#   name: "Ho Ad Ten Min",
#   password: "123456",
#   password_confirmation: "123456",
#   gender: 0,
#   birthday: Time.zone.now - 22.years,
#   address: FFaker::Address.street_address,
#   company: FFaker::CompanyIT.name,
#   role: 0
# )
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
  dating_information_attributes: {
    height: Random.rand(160..190),
    weight: Random.rand(50..100),
    dating_location: "Ha Noi",
    dating_distance: Random.rand(10..50),
    start_age: 18,
    end_age: 50,
    prefer_gender: 2,
    description: FFaker::Lorem.sentence
  }
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
  dating_information_attributes: {
    height: Random.rand(160..190),
    weight: Random.rand(50..100),
    dating_location: "Ha Noi",
    dating_distance: Random.rand(10..50),
    start_age: 18,
    end_age: 50,
    prefer_gender: 2,
    description: FFaker::Lorem.sentence
  }
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
  dating_information_attributes: {
    height: Random.rand(160..190),
    weight: Random.rand(50..100),
    dating_location: "Ha Noi",
    dating_distance: Random.rand(10..50),
    start_age: 18,
    end_age: 50,
    prefer_gender: 2,
    description: FFaker::Lorem.sentence
  }
)

40.times do |n|
  location = ["Ha Noi, Viet Nam", "Ho Chi Minh", "Da Nang"].sample
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
    dating_information_attributes: {
      height: Random.rand(160..190),
      weight: Random.rand(50..100),
      dating_location: location,
      dating_distance: Random.rand(10..50),
      start_age: Random.rand(18..25),
      end_age: Random.rand(35..70),
      prefer_gender: Random.rand(0..2),
      description: FFaker::Lorem.sentence
    }
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
