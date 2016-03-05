class Reservation < ActiveRecord::Base

  attr_accessor :slug
  before_save :military_time
  after_create :update_playday_slots

  belongs_to :user
  validates :six_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :eight_hundred, :inclusion => {:in => 0..15}, presence: true
  validates :time, presence: true

  validates :date, presence: true
  validates :user, presence: true


  default_scope { order('date ASC') }
  default_scope { order('timez ASC') }

def military_time
  case self.time
  when "8 am"
    self.timez = 800
  when "9 am"
    self.timez = 900
  when "10 am"
    self.timez = 1000
  when "11 am"
    self.timez = 1100
  when "12 pm"
    self.timez = 1200
  when "1 pm"
    self.timez = 1300
  when "2 pm"
    self.timez = 1400
  when "3 pm"
    self.timez = 1500
  when "4 pm"
    self.timez = 1600
  when "5 pm"
    self.timez = 1700
  when "6 pm"
    self.timez = 1800
  when "7 pm"
    self.timez = 1900
  end
end
=begin  def military_time
  converts = {
    "8 am" => 800,
    "9 am" => 900,
    "10 am" => 1000,
    "11 am" => 1100,
    "12 pm" => 1200,
    "1 pm" => 1300,
    "2 pm" => 1400,
    "3 pm" => 1500,
    "4 pm" => 1600,
    "5 pm" => 1700,
    "6 pm" => 1800,
    "7 pm" => 1900,
    "8 pm" => 2000,
  }
    self.timez = (self.time[converts]).to_s
  end
=end

  default_scope { order('timez ASC') }


  extend FriendlyId
    friendly_id :playday_id, use: :slugged


    time = {
      "8 am" => 800,
      "9 am" => 900,
      "10 am" => 1000,
      "11 am" => 1100,
      "12 pm" => 1200,
      "1 pm" => 1300,
      "2 pm" => 1400,
      "3 pm" => 1500,
      "4 pm" => 1600,
      "5 pm" => 1700,
      "6 pm" => 1800,
      "7 pm" => 1900,
      "8 pm" => 2000,
    }

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

  def total_estimate
    six + eight + photos #-discount
  end

  def six
    if self.six_hundred.nil?
      0
    else
      65*(self.six_hundred)
    end
  end

  def total_flights
    (self.six_hundred || 0) + (self.eight_hundred || 0)
  end

  def eight
    if self.eight_hundred.nil?
      0
    else
      75*(self.eight_hundred)
    end
  end

  def photos
    if self.photo.nil?
      0
    else
      30*(self.photo)
    end
  end

  def discount_codes
  end
end
