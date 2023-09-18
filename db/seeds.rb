# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'
require 'date'
require 'securerandom'
require 'pry-byebug'

seed_members = true
seed_users = true
seed_splits = true
seed_bills_and_items = true
# seed_payers = true
# seed_items = true

if seed_members
  puts "\n\n===== Creating members =====\n"

  puts 'Clearing old data...'
  Member.destroy_all
  # phone_no = "#{["8","9"].sample}#{7.times { rand(9).to_s }}"
  # phone_no = (8..9).to_a.sample.to_s + rand((10**6)..((10**7) - 1)).to_s

  members = []
  puts "Creating John Doe..."
  member1 = Member.create!(
    phone_number: "91231239"
  )
  puts "Created John Doe.\n\n"

  puts "Creating 10 Members with accounts"
  10.times do
    member = Member.create!(
      phone_number: rand(90_000_000..99_999_999).to_s
    )
    members << member
    puts "Created member."
  end

  puts "Creating 10 Members without accounts"
  10.times do
    member = Member.create!(
      phone_number: rand(90_000_000..99_999_999).to_s
    )
    puts "Created member."
  end
end

# # -------------------------------------------------------

if seed_users
  puts "===== Creating Users =====\n\n"

  puts 'Clearing old data'
  User.destroy_all
  users = []

  user1 = User.create!(
    member: member1,
    username: "Test1",
    email: "test123@gmail.com",
    first_name: "Zohan",
    last_name: "Goh",
    password: "password"
  )
  puts "Created #{user1.username}."
  10.times do |index|
    user = User.create!(
      member: members.shift,
      username: "User#{index}",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "password"
    )
    users << user
    puts "Created #{user.username}."
  end
end
# # ----------------------------------------------------

puts "\n\n===== Creating Contacts =====\n"
puts 'Clearing old data...'
Contact.destroy_all

puts 'Adding Zohan into contacts...'
Contact.create!(
  user: user1,
  member: member1,
  nickname: 'The Zohan'
)
Member.first(5).each_with_index do |member, index|
puts 'Adding another contact...'
  Contact.create!(
    user: user1,
    member:,
    nickname: "friend #{index + 1}"
  )
end

# # ----------------------------------------------------

if seed_splits
  puts "\n\n===== Creating splits =====\n"

  puts 'Clearing old data...'
  Split.destroy_all

  def split_date
    Date.today + rand(10).days
  end

  def six_digit_code
    rand(1_000_000).to_s.rjust(6, '0')
  end
  # statuses = ["draft", "pending", "complete"]

  split1 = Split.create!(
    user: user1,
    status: "draft",
    name: "my first split",
    date: split_date,
    invite_code: six_digit_code
  )
  puts "Created #{split1.name}."

  split2 = Split.create!(
    user: user1,
    status: "pending",
    name: "lunch meal",
    date: split_date,
    invite_code: six_digit_code
  )
  puts "created #{split2.name}."

  split3 = Split.create!(
    user: user1,
    status: "complete",
    name: "dinner meal",
    date: split_date,
    invite_code: six_digit_code
  )
  puts "created #{split3.name}."



  Split.all.each do |split|
    split.members << split.user.member
    members = Member.where.not(user:split.user).sample(2)
    members.each do |member|
      split.members << member
    end
  end
end

# ----------------------------------------------------

if seed_bills_and_items
  def create_items(bill)
    puts "   creating items..."
    rand(1..5).times do
      item = Item.create!(
        name: Faker::Food.dish,
        bill:,
        quantity: rand(1..3),
        price: rand(100..10_000)
      )
      puts "   - created #{item.name}"
    end
  end

  def create_payers(bill)
    puts "    adding payers"
    bill_members = bill.split.members

    rand(1..3).times do
      payer = Payer.create!(
        bill:,
        member: bill_members[(rand(bill_members.count))]
      )
      puts "    -created payers"
    end
  end

  def assign_members_to_items(bill)
    puts "    adding members (consumers) to items"
    bill_members = bill.split.members
    items = bill.items
    items.each do |item|
      rand(1..3).times do
        item_member = ItemMember.create!(
          item:,
          member: bill_members[rand(bill_members.count)]
        )
        puts "    -created member for item #{item.name}"
      end
    end
  end

  def create_bills(split)
    puts "\nCreating bills for split: #{split.name}..."
    rand(1..3).times do
      merchant = Faker::Restaurant.name
      puts "Creating Bill for #{merchant}"
      bill = Bill.create!(merchant:, split:)
      create_items(bill)
      create_payers(bill)
      assign_members_to_items(bill)
      puts "created Bill for #{merchant}\n\n"
    end
  end

  puts "\n\n===== Creating bills & items =====\n"

  puts 'clearing old data...'
  Bill.destroy_all
  Item.destroy_all

  Split.all.each { |split| create_bills(split) }

end

# ----------------------------------------------------
