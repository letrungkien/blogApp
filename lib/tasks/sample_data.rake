namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
  end
end

def make_users
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@blogapp.com"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_entries
  users = User.all(limit: 6)
  50.times do
    title = Faker::Lorem.sentence(5)
    body = Faker::Lorem.sentences(5)
    users.each { |user| user.entries.create!(title: title, body: body) }
  end
end

