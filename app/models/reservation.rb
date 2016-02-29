class Reservation < ActiveRecord::Base

  attr_accessor :slug

  belongs_to :user
  validates :six_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :eight_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :time, presence: true

  validates :date, presence: true
  validates :user, presence: true

  after_create :update_playday_slots



  extend FriendlyId
    friendly_id :playday_id, use: :slugged





  def update_playday_slots
    times = {
      "8 am" => "eight_am",
      "9 am" => "nine_am",
      "10 am" => "ten_am",
      "11 am" => "eleven_am",
      "12 pm" => "twelve_pm",
      "1 pm" => "one_pm",
      "2 pm" => "two_pm",
      "3 pm" => "three_pm",
      "4 pm" => "four_pm",
      "5 pm" => "five_pm",
      "6 pm" => "six_pm",
      "7 pm" => "seven_pm",
      "8 pm" => "eight_pm",
    }

    @playday = Playday.find_by! date: date
    date = self.date
    six = self.six_hundred || 0
    eight = self.eight_hundred || 0
    total_reservations = six + eight
    attribute = times[self.time]
    @playday.update_attribute(attribute, @playday.send(attribute) - total_reservations)
  end
end
