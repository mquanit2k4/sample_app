# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create sample users
users = User.create!([
  { name: "John Doe", email: "john@example.com" },
  { name: "Jane Smith", email: "jane@example.com" },
  { name: "Bob Johnson", email: "bob@example.com" }
])

# Create sample microposts
users.each do |user|
  5.times do |i|
    user.microposts.create!(
      content: "This is micropost #{i + 1} from #{user.name}. Lorem ipsum dolor sit amet!"
    )
  end
end

puts "Created #{User.count} users and #{Micropost.count} microposts."
