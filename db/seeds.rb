playdate = (Date.today+1)
365.times do
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
    date: playdate.strftime("%m/%d/%Y").to_s
  )
  playdate += 1
end

puts "Seeds Finished"
puts "#{Playday.count} playdays created"
