# This file should contain all the record creation needed to seed the database
# with its default values.  The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings'
#   }]) Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Admin User",
             email: "admin@test.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Basic User",
             email: "basic@test.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Blogger User",
             email: "blogger@test.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: false,
             blogger: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Complete User",
             email: "complete@test.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             blogger: true,
             activated: true,
             activated_at: Time.zone.now)

40.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

4.times do
  article = Article.new(page: 'about')
  heading = Faker::Lorem.sentences(1)
  content = Faker::Lorem.paragraphs(4)
  article.title = heading
  article.body = content
  article.save
end

3.times do
  article = Article.new(page: 'contact')
  title = Faker::Lorem.sentences(1)
  body = Faker::Lorem.paragraphs(4)
  article.title = title
  article.body = body
  article.save
end

10.times do
  blogger = User.find_by(email: 'blogger@test.org')
  blog = Blog.new
  title = Faker::Lorem.sentences(1)
  descript = Faker::Lorem.sentences(1)
  body = Faker::Lorem.paragraphs(10)
  blog.title = title
  blog.descript = descript
  blog.body = body
  blog.user_id = blogger.id
  blog.save
end

5.times do
  blogger = User.find_by(email: 'complete@test.org')
  title = Faker::Lorem.sentences(1)
  descript = Faker::Lorem.sentences(1)
  body = Faker::Lorem.paragraphs(10)
  blogger.blogs.create!(title: title, descript: descript, body: body)
end
