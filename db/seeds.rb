
playdate = Time.at(Time.now.utc + Time.zone_offset('PST'))

user = User.new(
  firstname: "administrator",
  lastname: "jones",
  email: "admin@example.com",
  password: 'password',
  password_confirmation: 'password',
  role: 'admin')

  user.save!

  user = User.new(
  firstname: "standard",
  lastname: "jones",
  email: "standard@example.com",
  password: 'password',
  password_confirmation: 'password',
  role: 'standard')

  user.save!

730.times do
  Playday.create!(
    seven_am: 15,
    eight_am: 15,
    nine_am: 15,
    ten_am:  15,
    eleven_am: 15,
    twelve_pm: 15,
    one_pm: 15,
    two_pm: 15,
    three_pm: 15,
    four_pm: 15,
    five_pm: 15,
    six_pm: 15,
    seven_pm: 15,
    eight_pm: 15,
    date: playdate.strftime("%m-%d-%Y").to_s
  )
  playdate += 1
end

puts "Seeds Finished"
puts "#{Playday.count} playdays created"
puts "#{User.count} users created"
