playdate = Date.yesterday

user = User.new(
  firstname: "administrator",
  lastname: "jones",
  email: "admin@example.com",
  phone: "555-555-5555",
  password: 'password',
  password_confirmation: 'password',
  role: 'admin')

  user.save!

  user = User.new(
  firstname: "standard",
  lastname: "jones",
  email: "standard@example.com",
  phone: "555-555-5555",
  password: 'password',
  password_confirmation: 'password',
  role: 'standard')

  user.save!

730.times do
  Playday.create!(
    seven_am: 15,
    eight_am: 15,
    eight_thirty_am: 0,
    nine_am: 15,
    nine_thirty_am: 0,
    ten_am:  15,
    ten_thirty_am:  0,
    eleven_am: 15,
    eleven_thirty_am: 0,
    twelve_pm: 15,
    twelve_thirty_pm: 0,
    one_pm: 15,
    one_thirty_pm: 0,
    two_pm: 15,
    two_thirty_pm: 0,
    three_pm: 15,
    three_thirty_pm: 0,
    four_pm: 15,
    four_thirty_pm: 0,
    five_pm: 15,
    five_thirty_pm: 0,
    six_pm: 15,
    six_thirty_pm: 0,
    seven_pm: 15,
    seven_thirty_pm: 0,
    eight_pm: 15,
    date: playdate.strftime("%m-%d-%Y").to_s
  )
  playdate += 1
end

puts "Seeds Finished"
puts "#{Playday.count} playdays created"
puts "#{User.count} users created"
