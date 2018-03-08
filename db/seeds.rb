require 'faker'
require 'pry'
require 'json'
require 'open-uri'

Favorite.destroy_all
puts "Destroyed favorites"
Application.destroy_all
puts "Destroyed applications"
User.destroy_all
puts "Destroyed users"
Job.destroy_all
puts "Destroyed jobs"

puts "Drop it like it's Seed, drop it likes it's Seed.."


10.times do |job|

  puts "creating job"
  job = Job.new(
    title: Faker::Job.title,
    company: Faker::Company.name,
    description: "Lorem ipsum dolor amet activated charcoal XOXO gentrify biodiesel street art succulents. Pug farm-to-table dreamcatcher, small batch helvetica affogato beard austin. Thundercats beard tacos ennui kombucha squid brunch hammock everyday carry swag echo park af occupy tumeric selfies. Plaid air plant bicycle rights celiac taxidermy succulents. Deep v kombucha gentrify schlitz. Godard mlkshk letterpress unicorn quinoa, adaptogen banjo meh lyft four loko woke mixtape tilde poke."

    )
  job.save

  3.times do |i|
    job.salary_list.add(Job::SALARIES.sample, parse: false)
    job.save
  end

  2.times do |i|
    job.skill_list.add(Job::SKILLS.sample+"#{rand(1..5)}")
    job.save
  end

  job.value_list.add("30+ Days Parental Leave")
  job.value_list.add("401(k)")
  job.value_list.add("80\%+ Covered Health Insurance")
  job.value_list.add("Dental Insurance")

  8.times do |i|
    job.value_list.add(Job::VALUES.sample)
    job.save
  end

  job.location_list.add(["Greater Denver Area", "Remote"].sample)

  job.save!
end

10.times do |register|
  puts "generating Registration"
  Registration.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
    )
end

i= 1
10.times do |user|
  puts "creating user"
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    resume_file_path: Faker::File.mime_type,
    registration_id: Registration.find(i).id
    )
  user.save
  5.times do |i|
    user.skill_list.add(User::SKILLS.sample+"#{rand(1..5)}")
    user.save
    user.value_list.add(User::VALUES.sample)
    user.save
    user.salary_list.add(User::SALARIES.sample)
    user.save
  end
  user.location_list.add(User::LOCATIONS.sample)
  i += 1
  user.save!
end





# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
