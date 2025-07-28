User.create!(
  name: "Vu Minh Quan",
  email: "quanvm@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  birthday: 25.years.ago.to_date,
  gender: :male.to_s,
  admin: true,
  activated: true,
  activated_at: Time.zone.now
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
    gender: gender.to_s,
    activated: true,
    activated_at: Time.zone.now
  )
end

puts "✅ Created #{User.count} users successfully!"

users = User.order(:created_at).take(6)

30.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

puts "✅ Created #{Micropost.count} microposts."
