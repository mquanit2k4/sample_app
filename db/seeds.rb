User.create!(
  name: "Vu Minh Quan",
  email: "quanvm@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  birthday: 25.years.ago.to_date,
  gender: :male.to_s,
  admin: true
)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  gender = %i(male female other).sample

  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    birthday: Faker::Date.birthday(min_age: 16, max_age: 85),
    gender: gender.to_s
  )
end

puts "Created #{User.count} users successfully!"
